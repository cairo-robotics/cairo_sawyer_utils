# Make sure catkin workspace exists
if [ ! -d "~/catkin_ws/src" ]
then
    mkdir -p ~/catkin_ws/src
    cd ~/catkin_ws/
    catkin build
    wstool init src
fi

# Install catkin tools
sudo apt -y update
sudo apt -y install python-catkin-tools

# Setup Intera SDK (https://sdk.rethinkrobotics.com/intera/Workstation_Setup)
sudo apt -y install git-core python-argparse python-vcstools python-rosdep ros-kinetic-control-msgs ros-kinetic-joystick-drivers ros-kinetic-xacro ros-kinetic-tf2-ros ros-kinetic-rviz ros-kinetic-cv-bridge ros-kinetic-actionlib ros-kinetic-actionlib-msgs ros-kinetic-dynamic-reconfigure ros-kinetic-trajectory-msgs ros-kinetic-rospy-message-converter
cd ~/catkin_ws/src
git clone https://github.com/RethinkRobotics/sawyer_robot.git
wstool merge sawyer_robot/sawyer_robot.rosinstall
wstool update

# Move and edit setup script for local sims
cd ~/catkin_ws
cp src/intera_sdk/intera.sh .
sed -i "s|your_ip=\"192.168.XXX.XXX\"|\#your_ip= \"192.168.XXX.XXX\"|g" ./intera.sh
sed -i "s|\#your_hostname=\"my_computer.local\"|your_hostname=\"localhost\"|g" ./intera.sh
sed -i "s|ros_version=\"indigo\"|ros_version=\"kinetic\"|g" ./intera.sh

# Setup Sawyer simulator (https://sdk.rethinkrobotics.com/intera/Gazebo_Tutorial)
sudo apt -y install gazebo7 ros-kinetic-qt-build ros-kinetic-gazebo-ros-control ros-kinetic-gazebo-ros-pkgs ros-kinetic-ros-control ros-kinetic-control-toolbox ros-kinetic-realtime-tools ros-kinetic-ros-controllers ros-kinetic-xacro python-wstool ros-kinetic-tf-conversions ros-kinetic-kdl-parser ros-kinetic-sns-ik-lib
cd ~/catkin_ws/src
git clone https://github.com/RethinkRobotics/sawyer_simulator.git
wstool merge sawyer_simulator/sawyer_simulator.rosinstall
wstool update

# Install Sawyer MoveIt!
cd ~/catkin_ws/src
git clone https://github.com/RethinkRobotics/sawyer_moveit.git
wstool merge sawyer_moveit/sawyer_moveit.rosinstall
wstool update

# Finally build the workspace
cd ~/catkin_ws
sudo catkin build
