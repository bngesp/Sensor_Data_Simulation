/**
* Name: datafromsensor
* Author: bng
* Description: 
* Tags: Tag1, Tag2, TagN
*/

model datafromsensor

/* Insert your model definition here */

global{
	int nb_current_myagent <- 10;
	//int myagent_create <- 0;
	//int myagent_die <- 0;
	//float step <- 1 #hour;
	geometry shape<-square(500 #m);
	
	init{
		create myagent number:nb_current_myagent{
			do connect  to:"localhost" with_name:"sensor" port:1883;
		}
	}	
	/*reflex end_simulation when: nb_current_myagent = 0{
		do halt;
	}*/
	
	
}

species myagent skills:[network, moving]{
	int taille <- 5;
	
	/*reflex augmenter{
		if(taille >= 150){
			nb_current_myagent <- nb_current_myagent-1;
			//create myagent number:1;
			do die;
		}
		else {
			taille <- (taille+1);
		}
	}*/
	reflex deplacer when:!(taille >= 35){
		do wander;
	}
	
	reflex getNumber when:has_more_message()
	{	
		message mess <- fetch_message();
		write name + " get this message: " + mess.contents;	
		create myagent number:1{
			taille<- range(10, 100);	
		}
		write "un nouveau agent cree";
		nb_current_myagent <- nb_current_myagent+1;
	}
	
	aspect affichage{
		draw circle(taille) color: taille<125 ? #red:#green;
	}
	
}

experiment marche type:gui{
	output {
		display map{
			species myagent aspect:affichage;
		}
		
		/*display chart refresh:every(10) {
			chart "Nombre d'agent" type: series {
				data "Myagent create" value: nb_current_myagent color: #green;
				//data "Myagent die" value: myagent_die color: #red;
			}
		}*/
	}
}