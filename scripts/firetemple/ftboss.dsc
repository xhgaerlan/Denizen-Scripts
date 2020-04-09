# This thing handles the boss in the fire temple
# It was written by Wahrheit and you better believe it
# @author Wahrheit
# @version 1.0
# @last-updated September 5 2013

"Lord Emfyrius":
    type: assignment
    interact scripts:
    - Get Out My House
    actions:
        on assignment:
        - run 'script:Flame and Darkness' instant
        
"Flame and Darkness":
    type: task
    script:
    - teleport npc location:<npc.anchor[ftboss1]>
    - trigger name:proximity toggle:true radius:3
"Boss Format":
    type: format
    format: "<red>Lord Emfyrius<white><&co> <text>"
"Champion":
    type: task
    script:
    - teleport npc location:<npc.anchor[ftboss3]>
    - narrate "format:Boss Format" "It seems you are truly a powerful warrior... I have been bested."
    - narrate "format:Boss Format" "You may have conquered me, but this is not the end!"
    - narrate "<yellow>Emfyrius disappears in a fountain of lava. You hear a sort of shining sound coming from the main platform."
#    - switch state:on location:-4,74,1,ultimatus
#    - switch state:on location:-1,74,1,ultimatus
    - execute as_server "npc despawn 88"
    - execute as_server "npc spawn 93"
    - execute as_server "npc select 93"
    - execute as_server "npc anchor --assume 'ftoracle'"
    - zap "script:Get Out My House" "step:Victory"
    - zap "script:Flame Savior" "step:Congratulations"
    - flag player firetemplecomplete:1
    
    
"Get Out My House":
    type: interact
    steps:
        'Boss Battle*':
            proximity trigger:
                entry:
                    radius: 3
                    script:
                    - narrate "format:Boss Format" "You have chosen poorly, <player.name>. This is my kingdom, I am the Lord of Flame!"
                    - narrate "format:Boss Format" "I will engulf you!"
                    - teleport npc location:<npc.anchor[ftboss2]>                    
                    - listen kill script:Champion id:Miniboss type:entity target:Wither qty:2
                    - execute as_npc "warp <player.name> ftboss"
                    - execute as_npc "spawnmob wither 1 -13,127,-36"
                    - execute as_npc "spawnmob wither 1 13,127,-36"
                    - zap "step:In Combat"
        'In Combat':
            click trigger:
                script:
                - zap "step:Boss Battle"
        'Victory':
            click trigger:
                script:
                - narrate "format:Boss Format" "This is a debug message that you shouldn't be seeing!"
                    
# Preserve this section for if we ever get mob-type npc pathing working right.                    
#            Npcdeath Trigger:
#                script:
#                - narrate "format:Boss Format" "Master... I've failed you..."
#                - DIE
#                - switch state:on location:-4,74,1,ultimatus
#                - switch state:on location:-1,74,1,ultimatus