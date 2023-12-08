//Dash system with cooldown
if(DashCooldown = false){
	Speed = Speed*DashMultiplier 
	
	//Sets speed to normal after a set time 
	execute after DashTime seconds
		Speed = Speed/DashMultiplier
		DashCooldown = true
	done
	
	//This is the cooldown for dash 
	execute after DashCooldownTime seconds
		DashCooldown = false
	done
}




 