# Inside your root directory:
cd /
git clone https://github.com/Livox-SDK/Livox-SDK2.git
mkdir Livox-SDK2/build
cd Livox-SDK2/build
cmake .. && make -j4 && sudo make install

# Inside your root directory:
cd /
git clone https://github.com/Livox-SDK/livox_ros_driver2.git ws_livox/src/livox_ros_driver2

# Modify the following appropriately for your ros version
cd ws_livox/src/livox_ros_driver2
SEARCH="192.168.1.5"
REPLACE="192.168.1.50"
sed -i -e "s/$SEARCH/$REPLACE/g" /ws_livox/src/livox_ros_driver2/config/MID360_config.json
SEARCH="192.168.1.12"
REPLACE="192.168.1.108" #change .108 to .1 followed by the last two didgits of your LiDAR's serial number i.e. serial ends in 05 would be .105
sed -i -e "s/$SEARCH/$REPLACE/g" /ws_livox/src/livox_ros_driver2/config/MID360_config.json

source /opt/ros/kinetic/setup.sh
./build.sh ROS1 #or maybe ROS2
echo 'launchlidar() {' >> ~/.bashrc
echo 'source /ws_livox/devel/setup.sh && roslaunch livox_ros_driver2 $1_MID360.launch' >> ~/.bashrc
echo '}' >> ~/.bashrc

sudo apt update
sudo apt-get install software-properties-common

sudo add-apt-repository ppa:borglab/gtsam-develop
sudo apt update
sudo apt install libgtsam-dev libgtsam-unstable-dev

cd /
mkdir ws_mid360 && mkdir ws_mid360/src && cd ws_mid360/src
git clone https://github.com/nkymzsy/LIO-SAM-MID360.git -b Livox-ros-driver2
#yeah it's some random chinese guy's project but it works. If you need help reading docs get a google translate extension that can translate the page
cd ..
catkin_make
source devel/setup.bash
cd /
