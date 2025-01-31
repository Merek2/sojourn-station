
/mob/living/carbon/superior_animal/roach/Move()
	. = ..()
	if(buckled_mob)
		buckled_mob.dir = dir
		buckled_mob.forceMove(get_turf(src))
		buckled_mob.pixel_x = pixel_x

/mob/living/carbon/superior_animal/roach/proc/try_tame(var/mob/living/carbon/user, var/obj/item/weapon/reagent_containers/food/snacks/grown/thefood)
	if(!istype(thefood) || thefood.plantname != "ambrosia")
		return FALSE
	if(prob(min(40, 100 - user.stats.getStat(STAT_COG)*2)))
		visible_message("[src] hesitates for a moment...and then charges at [user]!")
		return TRUE //Setting this to true because the only current usage is attack, and it says it hesitates.
	//fruits and veggies are not there own type, they are all the grown type and contain certain reagents. This is why it didnt work before
	if(isnull(thefood.seed.chems["potato"]))
		return FALSE
	visible_message("[src] scuttles towards [user], examining the [thefood] they have in their hand.")
	can_buckle = TRUE
	if(do_after(src, taming_window, src)) //Here's your window to climb onto it.
		if(!buckled_mob || user != buckled_mob) //They need to be riding us
			can_buckle = FALSE
			visible_message("[src] snaps out of its trance and rushes at [user]!")
			return FALSE
		visible_message("[src] bucks around wildly, trying to shake  [user] off!") //YEEEHAW
		for(var/datum/language/L in user.languages)
			if(!L.name == LANGUAGE_CHTMANT)
				if(prob(40))
					visible_message("[src] thrashes around, and throws [user] clean off!")
					user.throw_at(get_edge_target_turf(src,pick(alldirs)),rand(1,3),30)
					unbuckle_mob()
					can_buckle = FALSE
					return FALSE
			else if(prob(10))
				visible_message("[src] thrashes around, and throws [user] clean off, despite their efforts to communicate with [src]!")
				user.throw_at(get_edge_target_turf(src,pick(alldirs)),rand(1,3),30)
				unbuckle_mob()
				can_buckle = FALSE
				return FALSE
		friends += user
		colony_friend = TRUE
		friendly_to_colony = TRUE
		visible_message("[src] reluctantly stops thrashing around...")
		return TRUE
	visible_message("[src] snaps out of its trance and rushes at [user]!")
	return FALSE