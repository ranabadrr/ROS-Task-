FROM ros:noetic-ros-core

# Install ROS packages and dependencies
RUN apt-get update && apt-get install -y \
    ros-noetic-rospy \
    ros-noetic-std-msgs \
    python3-pip \
    python3-catkin-tools \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory to the ROS workspace source folder
WORKDIR /root/catkin_ws/src

# Copy the ROS package (ros_task) into Docker container's ROS workspace
COPY ros_task /root/catkin_ws/src/ros_task

# Change directory to the root of the catkin workspace and build
WORKDIR /root/catkin_ws
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make"

# Source ROS and the workspace, then run the launch file
CMD /bin/bash -c "source /opt/ros/noetic/setup.bash && \
    source /root/catkin_ws/devel/setup.bash && \
    roslaunch ros_task ros_task.launch"
