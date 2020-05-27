Veteran_Nature_Helm_sealed_potential:
    type: item
    no_id: true
    material: Leather_Helmet
    display name: <&9>Verdant Leather Helm
    lore_list:
    - <&9><&o>Veteran
    - <&f>This helm is emanating a subtle radiance of nature magic, reminding you of life's splendor.
    - <&b>+0.25x Nature Magic Effectiveness
    - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.yaml_key[lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/head/0/4.0
        - generic.armorToughness/head/0/2.0
        - generic.armor/head/0/2.0equipment_type/armor
        nbt:
        - item_tier/veteran
        - sealed_potential/true
        - armor_set/veteran_nature
        - nature_magic_multiplier/0.25
        - enable_mana/true
        
Veteran_Nature_Chest_sealed_potential:
    type: item
    no_id: true
    material: Leather_Chestplate
    display name: <&9>Verdant Leather Chestplate
    lore_list:
    - <&9><&o>Veteran
    - <&f>This chestplate is emanating a subtle radiance of nature magic, reminding you of life's splendor.
    - <&b>+0.6x Nature Magic Effectiveness
    - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.yaml_key[lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/chest/0/8.0
        - generic.armorToughness/chest/0/2.0
        - generic.armor/chest/0/4.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - sealed_potential/true
        - armor_set/veteran_nature
        - nature_magic_multiplier/0.6
        - enable_mana/true
        
Veteran_Nature_Legs_sealed_potential:
    type: item
    no_id: true
    material: Leather_Leggings
    display name: <&9>Verdant Leather Leggings
    lore_list:
    - <&9><&o>Veteran
    - <&f>These leggings are emanating a subtle radiance of nature magic, reminding you of life's splendor.
    - <&b>+0.4x Nature Magic Effectiveness
    - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.yaml_key[lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/legs/0/6.0
        - generic.armorToughness/legs/0/2.0
        - generic.armor/legs/0/3.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - sealed_potential/true
        - armor_set/veteran_nature
        - nature_magic_multiplier/0.4
        - enable_mana/true
        
Veteran_Nature_Boots_sealed_potential:
    type: item
    no_id: true
    material: Leather_Boots
    display name: <&9>Verdant Leather Boots
    lore_list:
    - <&9><&o>Veteran
    - <&f>These boots are emanating a subtle radiance of nature magic, reminding you of life's splendor.
    - <&b>+0.25x Nature Magic Effectiveness
    - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.yaml_key[lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/feet/0/2.0
        - generic.armorToughness/feet/0/2.0
        - generic.armor/feet/0/2.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - sealed_potential/true
        - armor_set/veteran_nature
        - nature_magic_multiplier/0.25
        - enable_mana/true

veteran_nature_armor_set_data:
    type: yaml data
    debug: false
    set_name: veteran_nature
    set_variable: nature_magic_multiplier

veteran_nature_armor_set_bonuses:
    type: procedure
    definitions: set_piece_count
    scale:
        1: 0
        2: 0.25
        3: 0.5
        4: 1
    script:
    - determine <script.yaml_key[scale.<[set_piece_count].min[4].max[1].round>]>