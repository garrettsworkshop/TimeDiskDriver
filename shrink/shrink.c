#include <stdio.h>
#include <string.h>

int main (int argc, char *argv[]) {
    // Check argument count
    if (argc != 5) {
        fprintf(stderr, "Usage: %s <input_file> <map_output_file> <data_output_file> <end_output_file>\n", argv[0]);
        return -1;
    }
    
    // Open input file
    FILE *f_in = fopen(argv[1], "r");
    if (f_in == NULL) {
        fprintf(stderr, "Error! Could not open input file %s\n", argv[1]);
        return -1;
    }

    // Open map output file
    FILE *f_map = fopen(argv[2], "w");
    if (f_map == NULL) {
        fprintf(stderr, "Error! Could not open output file %s\n", argv[2]);
        return -1;
    }

    // Open bank output file
    FILE *f_data = fopen(argv[3], "w");
    if (f_data == NULL) {
        fprintf(stderr, "Error! Could not open output file %s\n", argv[3]);
        return -1;
    }

    // Open bank output file
    FILE *f_end = fopen(argv[4], "w");
    if (f_end == NULL) {
        fprintf(stderr, "Error! Could not open output file %s\n", argv[4]);
        return -1;
    }

    // Input image
    char image[1024*1024] = {0};
    #define IMAGE_BY_BANK(bank, index) image[(2048 * bank) + index]

    // Read all input into image array
    fread(image, 1024, 1024, f_in);

    // Map array
    unsigned char map[512] = {0};

    // Packed data array
    #define NUM_BANKS (256)
    char packed[NUM_BANKS][2048] = {0xFF};
    unsigned char packed_bank_start = 6;
    unsigned char packed_bank = packed_bank_start;

    // Go through all banks in image
    for (int bank = 0; bank < 512; bank++) {
        // Check if all 2048 bytes zero
        int any_ones = 0;
        for (int i = 0; i < 2048; i++) {
            if (IMAGE_BY_BANK(bank, i) != 0) { any_ones = 1; }
        }

        if (!any_ones) { // If chunk is all zeros
            map[bank] = 0;
        } else { // Else chunk has data
            memcpy(&packed[packed_bank], &IMAGE_BY_BANK(bank, 0), 2048);
            map[bank] = packed_bank++;
        }
    }

    // Write map file
    for (int i = 0; i < 256; i++) { fputc(map[2*i], f_map); }
    for (int i = 0; i < 256; i++) { fputc(map[2*i + 1], f_map); }
    fclose(f_map);

    // Write data file
    for (int bank = packed_bank_start; bank < packed_bank; bank++) {
        for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 256; j++) {
                fputc(packed[bank][8*j + i], f_data);
            }
        }
    }
    fclose(f_data);

    // Write end file, skipping first byte
    for (int i = 1; i < NUM_BANKS; i++) {
        fputc(packed[i][2047], f_end);
    }
    fclose(f_end);


    fclose(f_in);
}
