---
layout: post
title: Fire Emblem AI Analysis
tags: games
---

This post is a quick and dirty analysis of how the AI *might* be implemented in *Fire Emblem: Awakening*.  Since I've been playing **a lot** of Fire Emblem Awakening recently, I've been observing the AI, and the topic was sparked up on Reddit so I decided to analyze it a bit further and how improvements might be made.

# Prelude 
I am not an AI expert, game design expert or work at *Intelligent Systems* or *Nintendo*.  I want to discuss my speculation of the implementation of the AI, possible decisions of the design, and potential improvements that might have made the game more challenging or fun.

*Fire Emblem* is a popular turn-based strategy RPG, or SRPG, where you are the tactictian of an army.  You control several units of your choosing which you equip weapons, attack enemies, level up and so on.  

The level up system allows for random stat level ups based on the character and their class, such as 80% STR and 30% AGI, which means that you have an 80% chance of a 1 point STR gain and 30% chance of 1 point AGI gain.  This means you may get stat points, or may even get no stat points per level.

The basis of the "lunatic" mode of *Fire Emblem: Awakening* is more or less giving the AI an unfair advantage of stat points and more units than the other difficulty levels.  However, this devolves the gameplay to:
1. Using certain stronger characters to survive the first few levels
2. Hoping for strong stat gains since getting a poor stat gain may snowball the player into #3
3. Grinding extra levels to get a level advantage over the AI

In *Awakening*, a player can "abuse" the map and encounters to get more experience than within the storyline missions.  The basic story missions are set to have certain enemies and levels so a player can trivialize most missions by grinding experience on random encounters.

Instead of artificially increasing difficulty by throwing extra numbers at players, I believe that scaling enemies somewhat based on the player levels, a more challenging AI and more varied mission objectives should be used.

# The Current AI
The current AI is fairly basic and easily abusable.  Let's see a basic implementation:

{% highlight c++ %}
class Weapon {
  public:
	string weapon_name;
	unsigned int weapon_might;  // Might or Mt is the strength/damage of the weapon
	unsigned int range;	// How far the user must be to attack with the weapon
	unsigned int hit_rate; //A given hit rate
	unsigned int critical_rate;	//A given critical hit chance
};

class Unit {
  public:
	Weapon equipped_weapon;
	unsigned int current_hp;
	unsigned int movement_range;
}
{% endhighlight %}

So now we have weapons with statistics and an enemy to wield the weapon.  Of course, it's more complicated than this because of the enemy's stats and base hit/crit/avoid base stats but for now it's enough.

Now, there are two distinct types of enemy AI, defensive and blitz.  The defensive AI moves to attack enemies in range and blitz aggressively moves towards the player units to get into attacking range.

Then, the AI chooses a target what looks to be either a possible killing blow, or the target that will take the most damage.

{% highlight c++ %}
#define CRIT_MULTI = 3;
unsigned CalculateDamage(const Unit* target, Weapon weapon, bool* unit_dies) {
	// Basic calculation of expected damage.
	unsigned expected_damage((weapon.weapon_might + 
	  CRIT_MULTI * weapon.weapon_might * weapon.critical_rate) * weapon.hit_rate);
	*unit_dies = false;
	if (target->current_hp < expected_damage)
	{
		*unit_dies = true;
	}
	return expected_damage;
}

Unit* ChooseTarget() {
	vector<Units*> targets;
	GetAllTargets(&targets);
	Unit* optimal_target; 
	unsigned max_damage(0);
	for (vector<Units*>::const_iterator it = targets.begin(); it != targets.end(); ++it)
	{
		bool target_dies;
		unsigned damage(CalculateDamage(*it, *it->weapon, &target_dies);		
		if (target_dies)
		{
			optimal_target = * it;
			break;
		}
		else if (damage >= max_damage)
		{
			optimal_target = *it;
		}
	}
	return optimal_target;
}
{% endhighlight %}

Here's how the target choosing would probably be done.  Each unit checks every possible target and chooses the "optimal" target, the target which the unit can deal the most damage or expected to kill the target.

But looking at the logic, it is easily flawed:

1. If there is only one target, the unit will attack the unit unconditionally.  This means that one target that will take no damage from the attack will still be attacked, even if it means suicide for the unit.

2. Two targets, one near death but the hit rate is low versus a high health unit with guartaneed damage means that the optimal target is the near death one.  This almost never happens because with enough attacks the target should die which is a victory for the AI.

# Design Implications and Possible Changes

So why use this flawed AI?  The popular opinion is to avoid stalement conditions.  In Fire Emblem, there are terrain bonuses that increase avoid and defensive power.  So if the AI units were weaker than the player units, then would the AI just hold strong map points to boost its survivability.  But then that forces the player to attack into fortified positions.

While it's not a bad idea to have the player seige positions, it can also create a losing position for the player. By attacking into a seiged position, there is a chance that the player does not break the formation and may suicide units in exchange. However, the classic gameplay of *Fire Emblem* is having permament death on player units, meaning losing a unit is a reason to restart the entire mission.

So what should be done?  From an AI perspective, the AI should have a more reactive stance;  if the player is "baiting" with one unit, don't immediately suicide into the one unit.  Instead, a good idea would be to hold strong positions and shift units around the one target and try to get into a surrounding position.

Furthermore, the AI should tactically split into unit groups.  A few attacking groups and a defensive group.  The defensive group defends the objective while the attacking group tries to flank.  If the attacking groups are close to being wiped out, turn them into defensive AI and slowly retreat to the objective.

This creates a more dynamic feel to the AI which tries to protect the objectives (in certain missions) and allows the player to have a few different skirmies with the intent of breaking the enemy lines instead of waiting out an onslaught.

Another change to *Fire Emblem: Awakening* to accomodate the AI change would be to closely craft the maps to include different routes around fortified areas, including "safe-zones" for ranged attackers (ie, archers) and including new mechanics/abilities.  With a few more niche abilities, for example, using a flanking unit to teleport reinforcements with magic to create multi-pronged attacks allows for multiple ways to complete objectives without needing to completely annihilating every enemy unit to win.
