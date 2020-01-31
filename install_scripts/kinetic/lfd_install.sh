# Clone CAIRO CC-LfD
cd ~/catkin_ws/src && git clone https://github.com/cairo-robotics/cairo-lfd.git

# Clone CAIRO constraint classification
cd ~/catkin_ws/src && git clone https://github.com/cairo-robotics/constraint_classification.git

# Clone CAIRO robot interface
cd ~/catkin_ws/src && git clone https://github.com/cairo-robotics/cairo-robot-interface.git

# Clone CAIRO collision / scene repo
cd ~/catkin_ws/src && git clone https://github.com/cairo-robotics/collision_objects.git

# Install LfD Python requirements
cd ~/catkin_ws/src/cairo-lfd && pip install -r requirements.txt

# Finally build the workspace
cd ~/catkin_ws
sudo catkin build

# Add Intera setup script alias
echo 'alias sim="cd ~/catkin_ws && clear && ./intera.sh sim"' >> ~/.bashrc
