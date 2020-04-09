# This thing handles the boss in the fire temple
# It was written by Wahrheit and you better believe it
# @author Wahrheit
# @version 1.0
# @last-updated September 5 2013

"Emira Ivese":
    type: assignment
    interact scripts:
    - Water Boss Fight
    actions:
        on assignment:
        - run 'script:Ice and Corruption' instant
        
"Ice and Corruption":
    type: task
    script:
    - teleport npc location:<npc.anchor[wtboss1]>
    - trigger name:proximity toggle:true radius:3
"Water Boss Format":
    type: format
    format: "<red>Emira Ivese<white><&co> <text>"
"Water Champion":
    type: task
    script:
    - teleport npc location:<npc.anchor[wtboss3]>
    - narrate "format:Water Boss Format" "You are more than you appear... my time has come to an end."
    - narrate "format:Water Boss Format" "I may be defeated, but you will not best the others!"
    - narrate "<yellow>Ivese disappears in a rapidly-ascending shard of ice. You hear a sort of shining sound coming from the main platform."
#    - switch state:on location:-4,74,1,ultimatus
#    - switch state:on location:-1,74,1,ultimatus
    - execute as_server "npc despawn 185"
    - execute as_server "npc spawn 187"
    - execute as_server "npc select 187"
    - execute as_server "npc anchor --assume 'wtoracle'"
    - zap "script:Water Boss Fight" "step:Victory"
    - zap "script:Water Savior" "step:Congratulations"
    - flag player watertemplecomplete:1

"Water Boss Kill Tracker":
    type: world
    events:
        on player kills guardian:
#        - announce "Player kills guardian event activated"
        - if !<player.has_flag[water_boss_fight]> queue clear
#        - announce "Player has boss fight flag"
        - if <context.entity.elder> {
#          - announce "Elder trait detected"
          - flag player water_boss_fight:++
          - spawn e@guardian l@-11,131,259,ultimatus"
          - spawn e@guardian l@3,131,249,ultimatus"
          - spawn e@guardian l@-3,131,224,ultimatus"
          - spawn e@guardian l@-19,131,224,ultimatus"
          - spawn e@guardian l@-25,131,249,ultimatus"
          }
        - if <player.flag[water_boss_fight].as_int.is[==].to[3]> {
          - flag player water_boss_fight:!
          - run "script:Water Champion"
          }
   
"Water Boss Fight":
    type: interact
    steps:
        'Boss Battle*':
            proximity trigger:
                entry:
                    radius: 3
                    script:
                    - narrate "format:Water Boss Format" "You should not meddle in affairs that are above you, <player.name>. I am beyond your power."
                    - narrate "format:Water Boss Format" "Prepare to face your end!"
                    - teleport npc location:<npc.anchor[wtboss2]>                    
#                    - listen kill "script:Water Champion" id:wtboss type:entity target:guardian qty:2
                    - execute as_npc "summon Guardian -11 132 226 {Elder:1}"
                    - execute as_npc "summon Guardian 4 132 248 {Elder:1}"
                    - execute as_npc "summon Guardian -27 132 248 {Elder:1}"
#                    - spawn guardian l@-11,132,226 ultimatus"
#                    - spawn guardian l@4,132,248 ultimatus"
#                    - spawn guardian l@-27,132,248 ultimatus"
                    - flag player water_boss_fight:0
                    - execute as_npc "warp <player.name> wtboss"
                    - zap "step:In Combat"
        'In Combat':
            click trigger:
                script:
                - zap "step:Boss Battle"
        'Victory':
            click trigger:
                script:
                - narrate "format:Water Boss Format" "This is a debug message that you shouldn't be seeing!"
                    
# Preserve this section for if we ever get mob-type npc pathing working right.                    
#            Npcdeath Trigger:
#                script:
#                - narrate "format:Water Boss Format" "Master... I've failed you..."
#                - DIE
#                - switch state:on location:-4,74,1,ultimatus
#                - switch state:on location:-1,74,1,ultimatus