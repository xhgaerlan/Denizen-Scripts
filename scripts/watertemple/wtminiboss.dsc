# This thing handles mini-boss in the water temple
# It was written by Wahrheit and you better believe it
# @author Wahrheit
# @version 2.0
# @last-updated December 21 2017

"Lieutenant Iqueo":
    type: assignment
    interact scripts:
    - Water Fight Script
    actions:
        on assignment:
        - run 'script:Kill Water Invaders'
"Kill Water Invaders":
    type: task
    script:
    - teleport npc location:<npc.anchor[wtminiboss]>
    - trigger name:proximity toggle:true radius:6
"Water Servant Format":
    type: format
    format: "<yellow>Lieutenant Iqueo<white><&co> <text>"
"Water Proceed":
    type: task
    script:
    - teleport npc location:<npc.anchor[wtminiboss2]>
    - narrate "format:Water Servant Format" "Emira... I've failed you..."
    - narrate "<yellow>Some of the ice below you melts away."
    - switch state:on location:-7,77,146,ultimatus
    - switch state:on location:-7,77,148,ultimatus
    - execute as_server "npc despawn 186"
    - zap "script:Water Fight Script" "step:Leaving"
"Water More Mobs":
    type: task
    script:
    - execute as_npc "spawnmob guardian 1 -11,48,240"
    - execute as_npc "spawnmob guardian 1 -6,48,240"
    - execute as_npc "spawnmob guardian 1 -11,48,245"
    - execute as_npc "spawnmob guardian 1 -11,48,235"
    - execute as_npc "spawnmob guardian 1 -16,48,240"
"Water Miniboss Kill Listener":
    type: world
    events:
        on mythicmob WaterTemple-Miniboss dies:
        - run "script: Water Proceed"
"Water Fight Script":
    type: interact
    steps:
        'Water Miniboss*':
            proximity trigger:
                entry:
                    radius: 6
                    script:
                    - narrate "format:Water Servant Format" "I serve my mistress, Emira Ivese! I will not allow you to oppose her!"
                    - narrate "format:Water Servant Format" "I shall freeze you and shatter your soul. Minions, annihilate the intruder!"
#                    - listen kill "script:Water More Mobs" id:wtMiniboss type:entity target:Guardian qty:5
#                    - listen kill "script:Water More Mobs" id:wtMiniboss-2 type:entity target:Guardian qty:10
#                    - listen kill "script:Water More Mobs" id:wtMiniboss-3 type:entity target:Guardian qty:15
#                    - listen kill "script:Water More Mobs" id:wtMiniboss-4 type:entity target:Guardian qty:20
#                    - listen kill "script:Water Proceed" id:wtMiniboss-5 type:entity target:Guardian qty:25
#                    - execute as_npc "spawnmob guardian 1 -11,48,240"
#                    - execute as_npc "spawnmob guardian 1 -6,48,240"
#                    - execute as_npc "spawnmob guardian 1 -11,48,245"
#                    - execute as_npc "spawnmob guardian 1 -11,48,235"
#                    - execute as_npc "spawnmob guardian 1 -16,48,240"
                    - teleport npc location:<npc.anchor[wtminiboss2]>
                    - mmspawnmob mobtype:WaterTemple-Miniboss location:-10,45,245,ultimatus
                    - switch state:off location:-7,77,148,ultimatus
                    - zap "step:In Combat"
        'In Combat':
            click trigger:
                script:
                - zap "step:Water Miniboss"
        'Leaving':
            proximity trigger:
                exit:
                    radius: 10
                    script:
                    - narrate "format:Water Servant Format" "You'll never make it to Ivese!"
                    
# Preserve this section for if we ever get mob-type npc pathing working right.                    
#            Npcdeath Trigger:
#                script:
#                - narrate "format:Water Servant Format" "Master... I've failed you..."
#                - DIE
#                - switch state:on location:-4,74,1,ultimatus
#                - switch state:on location:-1,74,1,ultimatus