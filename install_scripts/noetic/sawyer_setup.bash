
#!/bin/bash

while true; do
    read -p "Would you like to install ROS Noetic?" yn
    case $yn in
        [Yy]* ) 
            sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list';

            sudo apt install curl; # if you haven't already installed curl
            curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -;

            sudo apt-get update;

            sudo apt-get --assume-yes install ros-noetic-desktop-full git python-argparse python-vcstools python-rosdep  python-rosinstall python-rosinstall-generator build-essential;
            
            break;;
        [Nn]* ) 
            break;;
        * ) echo "Please answer yes (y) or no (n).";;
    esac
done

WSPATH="${PWD}/sawyer_ws"
while true; do
    read -p "Would you like to build a ROS workspace called sawyer_ws in your current working directory?" yn
    case $yn in
        [Yy]* ) 
            mkdir -p "${WSPATH}/src" ;
            break;;
        [Nn]* )
            read -p "Okay, well then, please enter a path for your workspace, including the workspace name/directory..." input;
            WSPATH = $input
            mkdir -p "${WSPATH}/src" ;
            break;;
        * ) echo "Please answer yes (y) or no (n).";;
    esac
done

while true; do
    read -p "Would you like to build to automatically source ROS through sourcing setup.bash and exporting your workspace in your .bashrc?" yn
    case $yn in
        [Yy]* ) 
            echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
            echo "export ROS_WORKSPACE=${WSPATH}" >> ~/.bashrc
            source ~/.bashrc
            break;;
        [Nn]* )
            break;;
        * ) echo "Please answer yes (y) or no (n).";;
    esac
done

#Download intera SDK on workstation (ros_ws is your ros workspace)

cd "${WSPATH}/src"
sudo rosdep init
rosdep update

wstool init .
wget https://raw.githubusercontent.com/cairo-robotics/sawyer_robot/master/sawyer_robot.rosinstall
wstool merge sawyer_robot.rosinstall
wstool update


while true; do
    read -p "Would you like to build include CAIRO LfD packages as well?" yn
    case $yn in
        [Yy]* )
            cd "$WSPATH/src"
            git clone git@github.com:cairo-robotics/cairo-lfd.git ;
            git clone git@github.com:cairo-robotics/cairo-robot-interface.git ;
            git clone git@github.com:cairo-robotics/constraint_classification.git ;
            cd $WSPATH
            break;;
        [Nn]* )
            break;;
        * ) echo "Please answer yes (y) or no (n).";;
    esac
done

echo "Installing catkin tools CLI program...";
pip3 install -U catkin-tools

#Source and build
cd $WSPATH
source /opt/ros/noetic/setup.bash
source devel/setup.bash
catkin build

#Copy the intera.sh script
cp "${WSPATH}/src/intera_sdk/intera.sh" ~/ros_ws

