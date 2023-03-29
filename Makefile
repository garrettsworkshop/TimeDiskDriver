all: bin/TimeDisk.bin bin/C200.s bin/C800.s

obj:
	mkdir -p $@
bin:
	mkdir -p $@

bin/shrink: bin shrink/shrink.c
	gcc -o bin/shrink shrink/shrink.c

obj/driver.o: obj driver.s header.s iosel.s
	ca65 -o $@ driver.s --cpu 6502

bin/TimeDisk_image.bin: rom/TimeDisk_image.2mg rom/partitiontable.bin
	rm -f $@
	dd if=rom/partitiontable.bin of=$@
	dd if=rom/TimeDisk_image.2mg conv=notrunc of=$@ bs=64 skip=1 seek=16

bin/iosel.bin: bin obj/driver.o driver.cfg
	rm -f bin/iosel.bin
	rm -f bin/iostrb.bin
	ld65 -C driver.cfg -m obj/driver.map obj/driver.o

bin/iostrb.bin: bin/iosel.bin

bin/TimeDisk_image_map.bin: bin/shrink bin/TimeDisk_image.bin
	bin/shrink bin/TimeDisk_image.bin $@ bin/TimeDisk_image_data.bin bin/TimeDisk_image_end.bin

bin/TimeDisk_image_data.bin: bin/TimeDisk_image_map.bin

bin/TimeDisk_image_end.bin: bin/TimeDisk_image_map.bin

bin/TimeDisk_unpadded.bin: bin/iosel.bin bin/iostrb.bin bin/TimeDisk_image_map.bin bin/TimeDisk_image_data.bin bin/TimeDisk_image_end.bin rom/RamFactor-1.4.bin
	rm -f $@
	dd if=rom/RamFactor-1.4.bin       conv=notrunc of=$@ bs=256 seek=0  count=32
	dd if=bin/iosel.bin               conv=notrunc of=$@ bs=256 seek=16 count=8
	dd if=bin/iostrb.bin              conv=notrunc of=$@ bs=256 seek=32 count=8
	dd if=bin/TimeDisk_image_map.bin  conv=notrunc of=$@ bs=256 seek=40 count=4
	dd if=bin/TimeDisk_image_end.bin  conv=notrunc of=$@ bs=256 seek=39 count=2
	dd if=bin/TimeDisk_image_data.bin conv=notrunc of=$@ bs=256 seek=48

bin/TimeDisk.bin: bin/TimeDisk_unpadded.bin
	rm -f $@
	dd if=/dev/zero of=$@ bs=2048 count=64
	dd if=bin/TimeDisk_unpadded.bin of=$@ conv=notrunc

bin/C200.bin: bin/iosel.bin
	dd if=bin/iosel.bin of=$@ bs=256 skip=2

bin/C200.s: bin/C200.bin
	da65 --start-addr 49664 bin/C200.bin -o $@

bin/C800.bin: bin/iosel.bin
	dd if=bin/iostrb.bin of=$@ bs=256

bin/C800.s: bin/C800.bin
	da65 --start-addr 51200 bin/C800.bin -o $@

.PHONY: clean
clean:
	rm -fr bin obj
