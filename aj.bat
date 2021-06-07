@echo off
set fm=%3%
set text=%4%
if "%1%" == "help" ( 
	echo "aj [cha|web|edit|help] [add|del|list] [File Path And File name] [Text]"
	echo cha - View AvianJay's Channel
	echo web - View AvianJay's Website
	echo edit - edit the file
	echo help - get commands
	echo add - add text on file [press enter and type]
	echo del - delete the file
	echo list - List The File
) else (
	if "%1%" == "cha" (
		start https://www.youtube.com/channel/UCHOMz1OEGB6UK5Rhw4_tfNQ
	) else (
		if "%1%" == "web" ( 
			start http://ajmcserver.ddns.net/
		) else (
			if "%1%" == "edit" ( 
				if "%2%" == "" ( 
					echo please enter add or del
				) else (
					if "%2%" == "add" ( 
						if "%3%" == "" ( 
							echo please enter File Path And File name
						) else (
							if "%4%" == "" ( 
								echo please enter text
							) else (
								echo Typeing...
								echo %text% >> %fm%
								echo OK!
							)
						)
					) else (
						if "%2%" == "del" ( 
							if "%3%" == "" ( 
								echo please enter File Path And File name
							) else (
								del %3%
							)
						) else (
							if "%2%" == "list" ( 
								if "%3%" == "" ( 
									echo please enter File Path And File name
								) else (
									type %fm%
								)
							) else (
								echo type "aj help" to view commands
							)
						)
					)
				)
			)
		)
	)
)