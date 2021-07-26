# docker_manager


**build approache:**

* Clone the repository

* Add tag version to the end of source directory like:
   * docker-manager-1.0.0

* Create compress file with folowing command:
   * tar -czvf docker-manager_1.0.0.orig.tar.gz docker-manager-1.0.0
  
* Run folowing command:
  * dpkg-buildpackage -rfakeroot -us -uc
 
:grinning:
