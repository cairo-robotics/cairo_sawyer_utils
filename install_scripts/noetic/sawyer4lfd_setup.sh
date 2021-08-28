#########################
# Prompt to install ROS #
#########################

while true; do
    read -p "Is you current working directory your ROS workspace (e.g. sawyer_ws or ros_ws)? (y/n) " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

##############
# Source ROS #
##############
echo "Sourcing ROS Noetic...";
source /opt/ros/noetic/setup.sh

#####################################################
# Install useful Catkin Tools wrapper around caktin #
#####################################################
echo "Installing catkin tools CLI program...";
pip3 install -U catkin-tools

echo "Making a src/ folder in your workspace...";
mkdir src
cd ./src

###################
# CAIRO LfD Repos #
###################
echo "Cloning LfD specific repos...";
git clone git@github.com:cairo-robotics/cairo-lfd.git
git clone git@github.com:cairo-robotics/cairo-robot-interface.git
git clone git@github.com:cairo-robotics/constraint_classification.git

##############################
# Forked Intera/Sawyer Repos #
##############################

# These repos should have all the neccessary updates to run Sawyer with ROS Noetic.
echo "Cloning forked Intera/Sawyer repos...";
git clone git@github.com:cairo-robotics/intera_sdk.git
git clone git@github.com:cairo-robotics/sawyer_robot.git
git clone git@github.com:cairo-robotics/intera_common.git
git clone git@github.com:cairo-robotics/sawyer_moveit.git

###########################
# Build the ROS workspace #
###########################
cd ../
echo "Building your workspace...";
catkin build

###########################
# Build the ROS workspace #
###########################
cp ./src/intera_sdk/intera.sh ./
