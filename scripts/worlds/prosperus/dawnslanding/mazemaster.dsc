# This thing handles the dude that sits at the entrance to The Grand Library portal
# @author Wahrheit
# @version 1.0
# @last-updated July 28 2017

"Grand Librarian":
    type: assignment
    interact scripts:
    - Librarian
    actions:
        on assignment:
        - run "Library Assign" instant
"Librarian Format":
    type: format
    format: "<gray>Grand Librarian<white><&co> <text>"
"Library Assign":
    type: task
    script:
    - teleport npc location:<npc.anchor[mazemaster]>
    - trigger name:proximity toggle:true radius:3
    - flag server mazeclear:1
    - flag server maze-challenger-name:!
    - flag server maze-challenger:!
"Library Reset":
    type: world
    debug: false
    events:
        on system time 19:00:
        - flag server daily-maze:!
        - discord id:sxr message channel:343105813293826059 "<&lt><&at><&amp>223441207341219840<&gt>, the library completions have been reset!"
"Maze Tracker":
    type: world
    debug: false
    events:
        on player dies:
        - if !<server.has_flag[maze-challenger]>:
                - queue clear
        - if <server.has_flag[maze-challenger]> && <player.location.world> == 'w@prosperus' && <player.uuid> == <server.flag[maze-challenger]>:
            - flag server mazeclear:1
            - announce "<red><player.name> has been conquered by The Grand Library. It is now clear."
            - flag server maze-challenger:!
            - flag server maze-challenger-name:!
        on player changes world from prosperus:
        - if <server.has_flag[maze-challenger]> && <player.location.world> != 'w@prosperus' && <player.uuid> == <server.flag[maze-challenger]>:
            - flag server mazeclear:1
            - announce "<red><player.name> has abandoned The Grand Library. It is now clear."
            - flag server maze-challenger:!
            - flag server maze-challenger-name:!
        on home command:
        - if <server.has_flag[maze-challenger]> && <player.uuid> == <server.flag[maze-challenger]>:
            - flag server mazeclear:1
            - announce "<red><player.name> has abandoned The Grand Library. It is now clear."
            - flag server maze-challenger:!
            - flag server maze-challenger-name:!
        on spawn command:
        - if <server.has_flag[maze-challenger]> && <player.uuid> == <server.flag[maze-challenger]>:
            - flag server mazeclear:1
            - announce "<red><player.name> has abandoned The Grand Library. It is now clear."
            - flag server maze-challenger:!
            - flag server maze-challenger-name:!
        on player quits:
        - if <server.has_flag[maze-challenger]> && <player.uuid> == <server.flag[maze-challenger]>:
            - flag server mazeclear:1
            - flag server maze-challenger:!
            - flag server maze-challenger-name:!
            - determine passive "<red><player.name> has vanished into the mists and abandoned The Grand Library. It is now clear."         
            - flag server "maze-abandoner:->:<player.uuid>"
        on player joins:
        - if <server.has_flag[maze-abandoner]> && <player.uuid> == <server.flag[maze-abandoner]>:
            - execute as_server "warp <player.name> spawn"
            - flag server "maze-abandoner:<-:<player.uuid>"
            - narrate "<red>You disconnected while in The Grand Library and have been returned to spawn."
            - flag server mazeclear:1
"Player Reset":
    type: task
    script:
    # Clear the maze
    - teleport <npc[94]> location:<npc.anchor[maze-gen]]>
    - execute as_npc "cs maze bookshelf 25 25 4 e"
    - wait 1
#    - execute as_npc "warp <player.name> library-paste"
#    - wait 1
#    - execute as_op "/schem load library-blank"
#    - execute as_op "/paste"
    - execute as_npc "warp <player.name> library-maze"
#    - execute as_op "cs maze bookshelf 25 25 4"
#    - execute as_op "region sel library-maze"
#    - execute as_op "/replace glass air"
#    - execute as_op "/sel"    
    - teleport <npc[94]> location:<npc.anchor[mazemaster]]>
    
"Librarian":
    type: interact
    steps:
        'Greeting*':
            proximity trigger:
                entry:
                    radius: 3
                    script:
                    - narrate "format:Librarian Format" "Hello, <player.name>. Welcome to The Grand Library."
                    - zap 'step:Entrance'
#            click trigger:
#                script:
#                - narrate "format:Librarian Format" "You're at the step 'Greeting'! This is a debug message!"

        'Entrance':
            click trigger:
                script:
                - narrate "format:Librarian Format" "The Grand Library magically reforms itself - it is as alive as any other being in this world."
                - narrate "format:Librarian Format" "Twice each day, bold adventurers are rewarded for traversing its halls. Are you up to the challenge?"
                - zap 'step:Verify'
            proximity trigger:
                exit:
                    radius: 3
                    script:
                    - zap 'step:Greeting'
        'Verify':
            click trigger:
                script:
                - if <server.flag[mazeclear]> == 1:
                    - narrate "format:Librarian Format" "Very well. I wish you the very best of luck in your efforts."
                    - flag server mazeclear:!
                    - flag server maze-challenger:<player.uuid>
                    - flag server maze-challenger-name:<player.name>
                    - narrate "<yellow>The Librarian begins chanting a spell..."
                    #- run "Player Reset" instant
                    - teleport <npc[94]> location:<npc.anchor[maze-gen]]>
                    - execute as_npc "cs maze bookshelf 25 25 4 e"
                    - wait 1
                    - execute as_npc "warp <player.name> library-maze"
                    - teleport <npc[94]> location:<npc.anchor[mazemaster]]>
                    
                - else:
                    - narrate "format:Librarian Format" "Sorry, it appears the maze is currently being challenged by <server.flag[maze-challenger-name]>. You will have to wait."
#                    - narrate "format:Librarian Format" "Debug <server.flag[mazeclear]>"
            proximity trigger:
                exit:
                    radius: 3
                    script:
                    - zap 'step:Greeting'