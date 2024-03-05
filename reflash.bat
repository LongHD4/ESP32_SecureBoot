set COM_PORT=COM5

idf.py erase_flash -p %COM_PORT%

espsecure.py encrypt_flash_data --keyfile zbins/secure_signing_key.bin --address 0x000000 -o zbins/bootloader_encrypted.bin build/bootloader/bootloader-reflash-digest.bin
esptool.py --chip esp32 --port %COM_PORT% --baud 921600 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 40m --flash_size detect 0x000000 zbins/bootloader_encrypted.bin

espsecure.py encrypt_flash_data --keyfile zbins/secure_signing_key.bin --address 0x00D000 -o zbins/partitions_encrypted.bin build/partition_table/partition-table.bin
esptool.py --chip esp32 --port %COM_PORT% --baud 921600 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 40m --flash_size detect 0x00D000 zbins/partitions_encrypted.bin

espsecure.py encrypt_flash_data --keyfile zbins/secure_signing_key.bin --address 0x014000 -o zbins/otadata_encrypted.bin build/ota_data_initial.bin
esptool.py --chip esp32 --port %COM_PORT% --baud 921600 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 40m --flash_size detect 0x014000 zbins/otadata_encrypted.bin