
#!/bin/bash

while true; do
    read -p "Would you like to install ROS Noetic? (y/n) " yn
    case $yn in
        [Yy]* ) 
            sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros-latest.list';

            sudo apt install curl; # if you haven't already installed curl
            curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -;

            sudo apt-get update;

            sudo apt-get --assume-yes install ros-noetic-desktop-full git python3-vcstools python3-rosdep  python3-rosinstall python3-rosinstall-generator build-essential;
            
            break;;
        [Nn]* ) 
            break;;
        * ) echo "Please answer yes (y) or no (n). ";;
    esac
done

eval WSPATH="${HOME}/cairo/sawyer_ws"
while true; do
    read -p "Would you like to build a ROS workspace called sawyer_ws via the following directory path: ~/cairo/sawyer_ws ? (y/n) " yn
    case $yn in
        [Yy]* ) 
            mkdir -p "${WSPATH}/src" ;
            break;;
        [Nn]* )
            read -p "Okay, well then, please enter a path for your workspace, including the workspace name/directory: " input;
            eval WSPATH=$input ;
            mkdir -p "${WSPATH}/src" ;
            break;;
        * ) echo "Please answer yes (y) or no (n). ";;
    esac
done

while true; do
    read -p "Would you like to build to automatically source ROS through sourcing setup.bash and exporting your workspace in your .bashrc? (y/n) " yn
    case $yn in
        [Yy]* ) 
            echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
            echo "export ROS_WORKSPACE=${WSPATH}" >> ~/.bashrc
            source ~/.bashrc
            break;;
        [Nn]* )
            break;;
        * ) echo "Please answer yes (y) or no (n). ";;
    esac
done


while true; do
    read -p "Would you like proceed with installing Sawyer ROS packages? (y/n) " yn
    case $yn in
        [Yy]* ) 
            echo "Installing forked Intera packages from CAIRO Github organization..."
            cd ${WSPATH}/src

            wstool init .
            wget https://raw.githubusercontent.com/cairo-robotics/sawyer_robot/master/sawyer_robot.rosinstall
            wstool merge sawyer_robot.rosinstall
            wstool update
            break;;
        [Nn]* )
            break;;
        * ) echo "Please answer yes (y) or no (n). ";;
    esac
done




while true; do
    read -p "Would you like to include CAIRO LfD packages as well? (y/n) " yn
    case $yn in
        [Yy]* )
            cd "$WSPATH/src"
            git clone git@github.com:cairo-robotics/cairo-lfd.git ;
            git clone git@github.com:cairo-robotics/cairo-robot-interface.git ;
            git clone git@github.com:cairo-robotics/constraint_classification.git ;
            cd $WSPATH ;
            break;;
        [Nn]* )
            break;;
        * ) echo "Please answer yes (y) or no (n). ";;
    esac
done

while true; do
    read -p "Would you like to build your workspace as well? This will you catkin-tools catkin build... (y/n) " yn
    case $yn in
        [Yy]* )
            echo "Installing catkin tools CLI program..." ;
            pip3 install -U catkin-tools ;

            cd $WSPATH ;
            source /opt/ros/noetic/setup.bash ;
            catkin build ;
            source devel/setup.bash ;

            cp "${WSPATH}/src/intera_sdk/intera.sh" ~/ros_ws ;
            break;;
        [Nn]* )
            break;;
        * ) echo "Please answer yes (y) or no (n). ";;
    esac
done


