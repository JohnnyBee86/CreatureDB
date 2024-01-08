/*
1. How do I get what to roll and add for 
	the health of an Ancient White Dragon?

-- This would be useful for planing a fight for a game.
	(How much health is the boss going to have?)
*/

select HealthDieCount
	, DiceType
	, HealthModifier
from Creatures join Dice on
	Creatures.HealthDie = Dice.DiceID
where CreatureName = 'Ancient White Dragon'

/*
2. What Attacks does a Goblin have and is the target in range?

-- How does the Goblin attack a player?
*/

select AttackName
	, AttackRange
from Creatures join CreatureAttacks on
	Creatures.CreatureID = CreatureAttacks.CreatureID
	join Attacks on
	CreatureAttacks.AttackID = Attacks.AttackID
where CreatureName = 'Goblin'


/*
3. What Creatures can breath normally and underwater?

-- If you want to add extra danger or complications to an encounter.
	What if they're on a boat?
*/

select CreatureName
	, SpecialAbility
from Creatures join CreatureSpecialAbilities on
	Creatures.CreatureID = CreatureSpecialAbilities.CreatureID
	join SpecialAbilities on
	CreatureSpecialAbilities.SpecialAbilityID = SpecialAbilities.SpecialAbilityID

/*
4. What does an Ancient Bronze Dragon add to a saving throw?

-- A player has cast a spell or used an ability that causes 
	the Dragon to make a save.
*/

select SaveType
	, SaveModifier 
from Creatures join CreatureSaves on
	Creatures.CreatureID = CreatureSaves.CreatureID
	join Saves on
	CreatureSaves.SaveID = Saves.SaveID
where CreatureName = 'Ancient Bronze Dragon'

/*
5.  What creatures have Darkvision?

-- Want to be able to ambush the players at night without
	having to use torches that could give the attackers away
*/

select CreatureName
	, SenseType
from Creatures join CreatureSenses on
	Creatures.CreatureID = CreatureSenses.CreatureID
	join Senses on
	CreatureSenses.SenseID = Senses.SenseID
where SenseType = 'Darkvision'

/*
6.  What type of damage is an Ancient White Dragon
	resistant or immune to, if any?

-- The players might attack with something that many
	not supposed to work very well
*/

select DamageType
	, IsImmune
from Creatures join CreatureResistances on
	Creatures.CreatureID = CreatureResistances.CreatureID
	join DamageType on
	CreatureResistances.DamageResistanceID = DamageType.DamageID
where CreatureName = 'Ancient White Dragon'

/*
7.  What creature in the database is the hardest to hit?

-- What if you want to make the players feel like the battle is hard 
	because they can't hit their opponent
*/

select top 1 CreatureName
	,ArmorClass
from Creatures
order by ArmorClass desc