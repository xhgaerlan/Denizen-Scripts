CocoaCalvinAssignment:
    type: assignment
    interact scripts:
    - CocoaCalvinInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[CocoaCalvin]>
        - trigger name:proximity toggle:true
        - trigger name:chat toggle:true

CocoaCalvinFormat:
    type: format
    format: "<gray>Cocoa Calvin<white><&co> <text>"

CocoaCalvinInteract:
    type: interact
    steps:
        CocoaQuestOffer*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Cocoa]>:
                        - narrate format:CocoaCalvinFormat "Hey <player.name>, got some cocoa beans for me?"
                        - zap CocoaQuestDelivery
                    - else if <yaml[<[data]>].contains[quests.active.DailyGathering_Cocoa].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Cocoa]>:
                        - narrate format:CocoaCalvinFormat "Hey <player.name>, we need some cocoa beans to feed the people of Dawn's Landing. Can you help out?"
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyGathering_Cocoa].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Cocoa]>:
                    - run QuestAcceptHandler def:DailyGathering_Cocoa
            chat trigger:
                DailyGathering_CocoaAccept:
                    trigger: /yes|sure|okay|great/
                    hide trigger message: true
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Cocoa].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Cocoa]>:
                        - run QuestAcceptHandler def:DailyGathering_Cocoa
        CocoaQuestDelivery:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Cocoa]>:
                        - narrate format:CocoaCalvinFormat "Hey <player.name>, got those cocoa beans for me?"
                    - else:
                        - zap CocoaQuestOffer

DailyGathering_CocoaQuestDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage 1
    - define quest_internalname DailyGathering_Cocoa
    - if <player.item_in_hand.material.name> == cocoa_beans:
        - define objective 1
        - inject QuestItemDeliveryHandler
        - if <[InProgress]>:
            - narrate format:CocoaCalvinFormat <proc[ItemDescriptionHandler_Gathering].context[<[delivery_item]>]>