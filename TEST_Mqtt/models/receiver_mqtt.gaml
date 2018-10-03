/**
* Name: receivermqtt
* Author: bng
* Description: 
* Tags: Tag1, Tag2, TagN
*/

model receivermqtt


global {	
	geometry shape<-square(500 #m);
	init {
		write "A MQTT server should run." color: #red;
		write "Another instance of GAMA should run the model Example_MQTT_Send.gaml, so that an agent can send messages.";
		
		
		create NetworkingAgent number:1{
			/**
			 * Demo connection based on the demo gama server. 
			 * Using the demo gama server requires an available internet connection. Depending on your web access, It could be slow down the simulation. 
			 * It is a free and unsecure server.
			 * Using YOUR server is thus adviced. You can download free solution such as ActiveMQ (http://activemq.apache.org) 
			 */
			do connect  to:"localhost" with_name:"/test" port:1883;
			
			//default ActiveMQ mqtt login is "admin", the password is "password"
			//do connect to:"localhost" with_name:name;
		}
	}
}

species NetworkingAgent skills:[network]{
	string name;
	string dest;
	reflex fetch when:has_more_message()
	{	
		message mess <- fetch_message();
		write name + " fecth this message: " + mess.contents;	
		//int test <- mess.contents;
		create myagent number:1{
			taille<- rnd(5)+rnd(5)+rnd(5);
			write "create agent with "+ taille+" taille"; //et la valeur" + test ;	
		}
	}
}

species myagent skills:[moving]{
	int taille <- 1;
	
	aspect afficher {
		draw circle(taille) color: taille >= 10 ? #red:#green;
	}
	
	reflex deplacer when:(taille >= 10){
		do wander;
	}
	
}
experiment Network_reciever type: gui {
	output {
		display map{
			species myagent aspect:afficher;
		}
	}
}