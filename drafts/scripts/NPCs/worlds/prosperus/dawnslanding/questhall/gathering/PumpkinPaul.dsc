PumpkinPaulAssignment:
    type: assignment
    interact scripts:
    - PumpkinPaulInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[PumpkinPaul]>
        - trigger name:proximity toggle:true
        - trigger name:chat toggle:true

PumpkinPaulFormat:
    type: format
    format: "<gray>Pumpkin Paul<white><&co> <text>"

PumpkinPaulInteract:
    type: interact
    steps:
        PumpkinQuestOffer*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Pumpkins]>:
                        - narrate format:PumpkinPaulFormat "Hey <player.name>, got some pumpkins for me?"
                        - zap PumpkinQuestDelivery
                    - else if <yaml[<[data]>].contains[quests.active.DailyGathering_Pumpkins].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Pumpkins]>:
                        - narrate format:PumpkinPaulFormat "Hey <player.name>, we need some pumpkins to feed the people of Dawn's Landing. Can you help out?"
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyGathering_Pumpkins].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Pumpkins]>:
                    - run QuestAcceptHandler def:DailyGathering_Pumpkins
            chat trigger:
                DailyGathering_PumpkinsAccept:
                    trigger: /yes|sure|okay|great/
                    hide trigger message: true
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Pumpkins].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Pumpkins]>:
                        - run QuestAcceptHandler def:DailyGathering_Pumpkins
        PumpkinQuestDelivery:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Pumpkins]>:
                        - narrate format:PumpkinPaulFormat "Hey <player.name>, got those pumpkins for me?"
                    - else:
                        - zap PumpkinQuestOffer

DailyGathering_PumpkinsQuestDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage 1
    - define quest_internalname DailyGathering_Pumpkins
    - if <player.item_in_hand.material.name> == Pumpkin:
        - define objective 1
        - inject QuestItemDeliveryHandler
        - if <[InProgress]>:
            - narrate format:PumpkinPaulFormat <proc[ItemDescriptionHandler_Gathering].context[<[delivery_item]>]>