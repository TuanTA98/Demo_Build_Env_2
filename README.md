# Demo_Build_Env_2

Prepare: Install STM32CubeMX to get the lib "https://www.st.com/en/development-tools/stm32cubeide.html"
		 Install Keil uVision5 to get the compiler "https://www.keil.com/download/"

Step 1: Update path in "MDK-ARM\build_env\local_config.bat"
Step 2: Use Command Prom => cd "C:\Users\HP\Desktop\Project\Batch_BuildEnv\Demo_Build_Env_2\MDK-ARM\build_env" (Update the coresponding path in the local)
Step 3: The format if command: cmd_env.bat [command] [option]
		Currently, the build environment support 2 command:
			- cmd_env.bat clean : clean output folder
			- cmd_env.bat build [TS_Name] : build coresponding test suite. ex: cmd_env.bat build TS_001