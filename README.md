# docker_manager


build approache:

1: Clone the repository

1: Add tag version to the end of source directory like:
   docker-manager-1.0.0

2: Create compress file with folowing command:
  tar -czvf docker-manager_1.0.0.orig.tar.gz docker-manager-1.0.0
  
3: Run folowing command:
  dpkg-buildpackage -rfakeroot -us -uc
  
