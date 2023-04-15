all: bin/TimeDisk_128.bin bin/TimeDisk_test512.bin

obj:
	mkdir -p $@
bin:
	mkdir -p $@

bin/shrink: bin shrink/shrink.c
	gcc -o bin/shrink shrink/shrink.c

obj/driver.o: obj driver.s header.s iosel.s
	ca65 -o $@ driver.s --cpu 6502

bin/iosel.bin: bin obj/driver.o driver.cfg
	rm -f bin/iosel.bin
	rm -f bin/iostrb.bin
	ld65 -C driver.cfg -m obj/driver.map obj/driver.o

bin/iostrb.bin: bin/iosel.bin



bin/TimeDisk_image128_map.bin: bin/shrink rom/TimeDisk_image128.bin
	bin/shrink rom/TimeDisk_image128.bin $@ bin/TimeDisk_image128_data.bin bin/TimeDisk_image128_end.bin

bin/TimeDisk_image128_data.bin: bin/TimeDisk_image128_map.bin

bin/TimeDisk_image128_end.bin: bin/TimeDisk_image128_map.bin

bin/TimeDisk_128_unpadded.bin: bin/iosel.bin bin/iostrb.bin bin/TimeDisk_image128_map.bin bin/TimeDisk_image128_data.bin bin/TimeDisk_image128_end.bin rom/RamFactor-1.4.bin
	rm -f $@
	dd if=rom/RamFactor-1.4.bin          conv=notrunc of=$@ bs=256 seek=0  count=32
	dd if=bin/iosel.bin                  conv=notrunc of=$@ bs=256 seek=16 count=8
	dd if=bin/iostrb.bin                 conv=notrunc of=$@ bs=256 seek=32 count=8
	dd if=bin/TimeDisk_image128_map.bin  conv=notrunc of=$@ bs=256 seek=40 count=4
	dd if=bin/TimeDisk_image128_end.bin  conv=notrunc of=$@ bs=256 seek=39 count=2
	dd if=bin/TimeDisk_image128_data.bin conv=notrunc of=$@ bs=256 seek=48

bin/TimeDisk_128.bin: bin/TimeDisk_128_unpadded.bin
	rm -f $@
	dd if=/dev/zero of=$@ bs=2048 count=64
	dd if=bin/TimeDisk_128_unpadded.bin of=$@ conv=notrunc



bin/TimeDisk_test512_map.bin: bin/shrink rom/TimeDisk_test512.bin
	bin/shrink rom/TimeDisk_test512.bin $@ bin/TimeDisk_test512_data.bin bin/TimeDisk_test512_end.bin

bin/TimeDisk_test512_data.bin: bin/TimeDisk_test512_map.bin

bin/TimeDisk_test512_end.bin: bin/TimeDisk_test512_map.bin

bin/TimeDisk_test512_unpadded.bin: bin/iosel.bin bin/iostrb.bin bin/TimeDisk_test512_map.bin bin/TimeDisk_test512_data.bin bin/TimeDisk_test512_end.bin rom/RamFactor-1.4.bin
	rm -f $@
	dd if=rom/RamFactor-1.4.bin         conv=notrunc of=$@ bs=256 seek=0  count=32
	dd if=bin/iosel.bin                 conv=notrunc of=$@ bs=256 seek=16 count=8
	dd if=bin/iostrb.bin                conv=notrunc of=$@ bs=256 seek=32 count=8
	dd if=bin/TimeDisk_test512_map.bin  conv=notrunc of=$@ bs=256 seek=40 count=4
	dd if=bin/TimeDisk_test512_end.bin  conv=notrunc of=$@ bs=256 seek=39 count=2
	dd if=bin/TimeDisk_test512_data.bin conv=notrunc of=$@ bs=256 seek=48

bin/TimeDisk_test512.bin: bin/TimeDisk_test512_unpadded.bin
	rm -f $@
	dd if=/dev/zero of=$@ bs=2048 count=256
	dd if=bin/TimeDisk_test512_unpadded.bin of=$@ conv=notrunc


.PHONY: clean
clean:
	rm -fr bin obj
