SearingFlames_Power_Handler:
    type: world
    debug: false
    events:
        on magicspells player casts spell:
        - if <context.spell_name> != searingflames:
            - queue clear
        - else:
            - define fire_power <proc[Magic_Power_Handler].context[fire]>
            - determine power:<[fire_power].div[100].mul[1.1]>