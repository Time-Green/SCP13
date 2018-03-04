/datum/scp
	name = "SCP-173"
	designation = "173"
	classification = KETER

/mob/living/simple_animal/hostile/SCP_173
	name = "sculpture"
	desc = "An eerie, motionless sculpture."
	icon = 'icons/SCP/173.dmi'
	icon_state = "173"
	gender = NEUTER

	response_help = "touches"
	response_disarm = "pushes"

	speed = 0
	maxHealth = 99999
	health = 99999

	melee_damage_lower = 5
	melee_damage_upper = 20

	minbodytemp = 0

	faction = list("SCP")
	move_to_delay = 0 // Very fast

	animate_movement = NO_STEPS
	see_in_dark = 13

	sight = SEE_SELF|SEE_MOBS|SEE_OBJS|SEE_TURFS
	anchored = TRUE


/mob/living/simple_animal/hostile/SCP_173/Move(turf/NewLoc)
	if(can_be_seen(NewLoc))
		to_chat(src, "<span class='notice'> We can't move, we're being watched.</span>")
		return
	return ..()

/mob/living/simple_animal/hostile/SCP_173/proc/can_be_seen(turf/destination)
	var/list/check_list = list(src)
	if(destination)
		check_list += destination
	// This loop will, at most, loop twice.
	for(var/atom/check in check_list)
		for(var/mob/living/M in viewers(world.view + 1, check) - src)
			if(M.client)
				if(!InCone(M,OPPOSITE_DIR(M.dir)))
					if(!M.eye_blind)
						return M
	return null


/mob/living/simple_animal/hostile/SCP_173/AttackingTarget()
	if(can_be_seen(get_turf(loc)))
		to_chat(src, "<span class='notice'> We can't attack, we're being watched.</span>")
		return
	. = ..()
	if(. && isliving(.)) //Once in a blue moon this might be a mech
		var/mob/living/L = .
		L.death()
