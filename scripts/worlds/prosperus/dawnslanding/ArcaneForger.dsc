"Arcane Forger":
    type: assignment
    debug: false
    interact scripts:
    - Arcane Forger Forging
    actions:
        on assignment:
        - teleport npc <npc.anchor[badlucknpc]>
        - trigger name:proximity toggle:true
        - trigger name:chat toggle:true

"Arcane Forger Format":
    type: format
    debug: false
    format: "<dark_green>Arcane Forger<white><&co> <text>"

"Arcane Forger Forging":
    type: interact
    debug: true
    steps:
        "Player Seen*":
            proximity trigger:
                entry:
                    script:
                    - narrate "format:Arcane Forger Format" "Welcome, adventurer! I am a master of extracting magical energies and manipulating them for heroes like yourself. If you collect enough of these items on your adventures, I can help you harness this power."
                    - narrate "format:Arcane Forger Format" "The various services I can provide require different amounts of magical energy. Right click me to browse my offerings."
                exit:
                    script:
                    - narrate "format:Arcane Forger Format" "Good luck on your adventures! Visit me again when you need my help."
            click trigger:
                script:
                - narrate "format:Arcane Forger Format" "Okay, here's what I have to offer."
                - wait 1s
                - inventory open d:<inventory[ArcaneForgerInventoryMenu]>

ArcaneForgerInventoryMenu:
    type: inventory
    inventory: chest
    debug: false
    title: Arcane Forging
    size: 45
    slots:
    - "[] [] [] [] [] [] [] [] []"
    - "[] [] [] [VeteranToolForge] [] [VeteranWeaponForge] [] [] []"
    - "[] [] [] [] [] [] [] [] []"
    - "[] [] [] [EliteToolForge] [] [EliteWeaponForge] [] [] []"
    - "[] [] [] [] [] [] [] [] []"

VeteranToken:
    type: item
    debug: true
    material: bone
    display name: <&9>Phantasmal Bones
    lore_list:
    - <&6>The bones of a powerful monster, slain by a hero. When held, you can still feel energy pouring out of them.
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - enchants
        nbt:
        - badlucktoken/veteran
        - uncraftable/true
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[lore_list]>]>]>

VeteranToolForge:
    type: item
    debug: false
    material: diamond_pickaxe
    display name: <&9>Forge a Veteran Tool
    lore_list:
    - <&6>Requires <server.flag[VeteranToolForgeCost]> Phantasmal Bones and 1 Sliver of Crystallized Experience.
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[lore_list]>]>]>

VeteranWeaponForge:
    type: item
    debug: false
    material: diamond_sword
    display name: <&9>Forge a Veteran Armament
    lore_list:
    - <&6>Requires <server.flag[VeteranWeaponForgeCost]> Phantasmal Bones and 1 Sliver of Crystallized Experience.
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[lore_list]>]>]>

EliteToolForge:
    type: item
    debug: false
    material: diamond_pickaxe
    display name: <&d>Forge an Elite Tool
    lore_list:
    - <&6>Requires <server.flag[EliteToolForgeCost]> Phantasmal Bones and 1 Chunk of Crystallized Experience.
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[lore_list]>]>]>

EliteWeaponForge:
    type: item
    debug: false
    material: diamond_sword
    display name: <&d>Forge an Elite Armament
    lore_list:
    - <&6>Requires <server.flag[EliteWeaponForgeCost]> Phantasmal Bones and 1 Chunk of Crystallized Experience.
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[lore_list]>]>]>

ArcaneForgerInventoryHandler:
    type: world
    debug: true
    events:
        on server start:
        - flag server VeteranToolForgeCost:150
        - flag server VeteranWeaponForgeCost:200
        - flag server EliteToolForgeCost:900
        - flag server EliteWeaponForgeCost:1200
        on player clicks in ArcaneForgerInventoryMenu priority:100:
        - determine cancelled
        on player drags in ArcaneForgerInventoryMenu priority:100:
        - determine cancelled
        on player clicks VeteranToolForge in ArcaneForgerInventoryMenu:
        - inventory close
#        - narrate "format:Arcane Forger Format" "You clicked the Veteran Tool Forge option!"
        - announce to_console <player.inventory.list_contents>
        - if <player.inventory.contains[VeteranToken].quantity[<server.flag[VeteranToolForgeCost]>]> && <player.inventory.contains[CrystallizedExperienceSliver].quantity[1]>:
#            - narrate "format:Arcane Forger Format" "You have enough bones for a special magic doodad!"
            - take scriptname:VeteranToken quantity:<server.flag[VeteranToolForgeCost]>
            - take scriptname:CrystallizedExperienceSliver quantity:1
            - random:
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive an <&9>Imbued Axe<&f>!"
                    - announce to_console "<player.name> received an Imbued Axe"
                    - give <mythic_item[ImbuedAxe]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive an <&9>Imbued Pickaxe<&f>!"
                    - announce to_console "<player.name> received an Imbued Pickaxe"
                    - give <mythic_item[ImbuedPickaxe]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive an <&9>Imbued Shovel<&f>!"
                    - announce to_console "<player.name> received an Imbued Shovel"
                    - give <mythic_item[ImbuedShovel]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive an <&9>Imbued Hoe<&f>!"
                    - announce to_console "<player.name> received an Imbued Hoe"
                    - give <mythic_item[ImbuedHoe]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive an <&9>Imbued Fishing Rod<&f>!"
                    - announce to_console "<player.name> received an Imbued Fishing Rod"
                    - give <mythic_item[ImbuedFishingRod]> quantity:1
        - else:
            - narrate "format:Arcane Forger Format" "Sorry, you don't have enough for that!"
        - narrate "format:Arcane Forger Format" "Right click me again if you'd like to choose another option!"
        on player clicks VeteranWeaponForge in ArcaneForgerInventoryMenu:
        - inventory close
#        - narrate "format:Arcane Forger Format" "You clicked the Veteran Weapon Forge option!"
        - announce to_console <player.inventory.list_contents>
        - if <player.inventory.contains[VeteranToken].quantity[<server.flag[VeteranWeaponForgeCost]>]> && <player.inventory.contains[CrystallizedExperienceSliver].quantity[1]>:
#            - narrate "format:Arcane Forger Format" "You have enough bones for a special magic doodad!"
            - take scriptname:VeteranToken quantity:<server.flag[VeteranWeaponForgeCost]>
            - take scriptname:CrystallizedExperienceSliver quantity:1
            - random:
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive an <&9>Imbued Sword<&f>!"
                    - announce to_console "<player.name> received an Imbued Sword"
                    - give <mythic_item[ImbuedSword]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive an <&9>Imbued Bow<&f>!"
                    - announce to_console "<player.name> received an Imbued Bow"
                    - give <mythic_item[ImbuedBow]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive an <&9>Imbued Shield<&f>!"
                    - announce to_console "<player.name> received an Imbued Shield"
                    - give <mythic_item[ImbuedShield]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive an <&9>Imbued Helm<&f>!"
                    - announce to_console "<player.name> received an Imbued Helm"
                    - give <mythic_item[ImbuedHelm]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive an <&9>Imbued Chestplate<&f>!"
                    - announce to_console "<player.name> received an Imbued Chestplate"
                    - give <mythic_item[ImbuedChest]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a pair of <&9>Imbued Leggings<&f>!"
                    - announce to_console "<player.name> received Imbued Leggings"
                    - give <mythic_item[ImbuedLegs]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a pair of <&9>Imbued Boots<&f>!"
                    - announce to_console "<player.name> received Imbued Boots"
                    - give <mythic_item[ImbuedBoots]> quantity:1
        - else:
            - narrate "format:Arcane Forger Format" "Sorry, you don't have enough for that!"
        - narrate "format:Arcane Forger Format" "Right click me again if you'd like to choose another option!"
        on player clicks EliteToolForge in ArcaneForgerInventoryMenu:
        - inventory close
#        - narrate "format:Arcane Forger Format" "You clicked the Elite Tool Forge option!"
        - if <player.inventory.contains[VeteranToken].quantity[<server.flag[EliteToolForgeCost]>]> && <player.inventory.contains[CrystallizedExperienceChunk].quantity[1]>:
#            - narrate "format:Arcane Forger Format" "You have enough bones for a special magic doodad!"
            - take scriptname:VeteranToken quantity:<server.flag[EliteToolForgeCost]>
            - take scriptname:CrystallizedExperienceChunk quantity:1
            - random:
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a <&d>Burnished Axe<&f>!"
                    - announce to_console "<player.name> received a Burnished Axe"
                    - give <mythic_item[BurnishedAxe]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a <&d>Burnished Pickaxe<&f>!"
                    - announce to_console "<player.name> received a Burnished Pickaxe"
                    - give <mythic_item[BurnishedPickaxe]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a <&d>Burnished Shovel<&f>!"
                    - announce to_console "<player.name> received a Burnished Shovel"
                    - give <mythic_item[BurnishedShovel]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a <&d>Burnished Hoe<&f>!"
                    - announce to_console "<player.name> received a Burnished Hoe"
                    - give <mythic_item[BurnishedHoe]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a <&d>Burnished Fishing Rod<&f>!"
                    - announce to_console "<player.name> received a Burnished Fishing Rod"
                    - give <mythic_item[BurnishedFishingRod]> quantity:1
        - else:
            - narrate "format:Arcane Forger Format" "Sorry, you don't have enough for that!"
        - narrate "format:Arcane Forger Format" "Right click me again if you'd like to choose another option!"
        on player clicks EliteWeaponForge in ArcaneForgerInventoryMenu:
        - inventory close
#        - narrate "format:Arcane Forger Format" "You clicked the Elite Weapon Forge option!"
        - if <player.inventory.contains[VeteranToken].quantity[<server.flag[EliteWeaponForgeCost]>]> && <player.inventory.contains[CrystallizedExperienceChunk].quantity[1]>:
#            - narrate "format:Arcane Forger Format" "You have enough bones for a special magic doodad!"
            - take scriptname:VeteranToken quantity:<server.flag[EliteWeaponForgeCost]>
            - take scriptname:CrystallizedExperienceChunk quantity:1
            - random:
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a <&d>Burnished Sword<&f>!"
                    - announce to_console "<player.name> received a Burnished Sword"
                    - give <mythic_item[BurnishedSword]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a <&d>Burnished Bow<&f>!"
                    - announce to_console "<player.name> received a Burnished Bow"
                    - give <mythic_item[BurnishedBow]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a <&d>Burnished Shield<&f>!"
                    - announce to_console "<player.name> received a Burnished Shield"
                    - give <mythic_item[BurnishedShield]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a <&d>Burnished Helm<&f>!"
                    - announce to_console "<player.name> received a Burnished Helm"
                    - give <mythic_item[BurnishedHelm]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a <&d>Burnished Chestplate<&f>!"
                    - announce to_console "<player.name> received a Burnished Chestplate"
                    - give <mythic_item[BurnishedChest]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a pair of <&d>Burnished Leggings<&f>!"
                    - announce to_console "<player.name> received a Burnished Leggings"
                    - give <mythic_item[BurnishedLegs]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a pair of <&d>Burnished Boots<&f>!"
                    - announce to_console "<player.name> received a Burnished Boots"
                    - give <mythic_item[BurnishedBoots]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a <&d>Bountiful Blade<&f>!"
                    - announce to_console "<player.name> received a Bountiful Blade"
                    - give <mythic_item[BountifulBlade]> quantity:1
                - repeat 1:
                    - narrate "format:Arcane Forger Format" "The magics coalesce... and you receive a <&d>Withering Blade<&f>!"
                    - announce to_console "<player.name> received a Withering Blade"
                    - give <mythic_item[WitheringBlade]> quantity:1
        - else:
            - narrate "format:Arcane Forger Format" "Sorry, you don't have enough for that!"
        - narrate "format:Arcane Forger Format" "Right click me again if you'd like to choose another option!"