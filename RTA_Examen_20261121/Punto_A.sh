sudo fdisk -l 
sudo pvcrate /dev/sdd /dev/sdc
sudo vgcreate vg_datos /dev/sdd 
sudo vgcreate vg_temp /dev/sdc
sudo lvcreate -L 5M -n lv_docker vg_datos
sudo lvcreate -L 1.5G -n lv_workareas vg_datos
sudo lvcreate -L 512M -n lv_swap vg_temp
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
sudo mkdir -p /var/lib/docker
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas
sudo mkdir -p /work
sudo mount /dev/mapper/vg_datos-lv_workareas /work
sudo mkswap /dev/mapper/vg_temp-lv_swap
sudo swapon /dev/mapper/vg_temp-lv_swap
sudo systemctl restart docker
sudo systemctl status docker
