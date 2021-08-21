project "GLFW"

	location "%{wks.location}/Dependencies/GLFW"

	-- Output Directories --
	targetdir (target_dir)
	objdir    (object_dir)

	-- Compiler --
	kind "StaticLib"
	language "C"

	-- Project Files ---
	files
	{
		-- includes
		"include/GLFW/glfw3.h",
		"include/GLFW/glfw3native.h",

		-- source
		"src/glfw_config.h",
		"src/context.c",
		"src/init.c",
		"src/input.c",
		"src/monitor.c",
		"src/vulkan.c",
		"src/window.c",

		"%{prj.location}/build.lua",
	}
	
	--- Filters ---
	-- windows
	filter "system:windows"
		systemversion "latest"
		staticruntime "On"

		files
		{
			"src/win32_init.c",
			"src/win32_joystick.c",
			"src/win32_monitor.c",
			"src/win32_time.c",
			"src/win32_thread.c",
			"src/win32_window.c",
			"src/wgl_context.c",
			"src/egl_context.c",
			"src/osmesa_context.c",
		}

		defines 
		{ 
			"_GLFW_WIN32",
			"_CRT_SECURE_NO_WARNINGS",
		}

		flags { "MultiProcessorCompile" }
		
	-- linux
	filter "system:linux"
		files
		{
			"src/x11_init.c", 
			"src/x11_window.c",
			"src/x11_monitor.c",
			"src/linux_joystick.c",
			"src/egl_context.c",
			"src/osmesa_context.c",
			"src/posix_thread.c",
			"src/posix_time.c",
			"src/glx_context.c",
			"src/xkb_unicode.c",
		}
		
		links
		{
			"dl",
		}
		
		buildoptions
		{
			"-lgtest",
			"-lpthread",
		}
		
		defines
		{
			"_GLFW_X11",
		}

	-- debug
	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	-- release
	filter "configurations:Release"
		runtime "Release"
		optimize "on"

	-- distribution
	filter "configurations:Distribution"
		runtime "Release"
		optimize "full"
