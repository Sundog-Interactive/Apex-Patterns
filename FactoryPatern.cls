public class FactoryPatern {
    public static void doStuff(String input){
        EnemyShipFactory shipFactory = new EnemyShipFactory();
        EnemyShip theEnemy = shipFactory.makeEnemyShip(input);
        
        if(theEnemy != null){
            doStuffEnemy(theEnemy);
        }
    }
    
    public static void doStuffEnemy(EnemyShip anEnemyShip){
        anEnemyShip.followHeroShip();
        anEnemyShip.displayEnemyShip();
        anEnemyShip.enemyShipShoots();
    }

    public abstract class EnemyShip{
        private String name;
        private Double amtDamage;
        
        public String getName(){
            return name;         
        }
        
        public void setName(String newName){
            name = newName;
        }
        
        public Double getAmtDamage(){
            return amtDamage;         
        }
        
        public void setAmtDamage(Double newDamage){
            amtDamage = newDamage;
        }
        
        public void followHeroShip(){
            System.debug(getName() + ' is following the hero');
        }

        public void displayEnemyShip(){
            System.debug(getName() + ' is on the screen');
        }
        
        public void enemyShipShoots(){
            System.debug(getName() + ' attacks and does ' + getAmtDamage());
        }
    }
    
    public class EnemyShipFactory{
        public EnemyShip makeEnemyShip(String shipType){
            EnemyShip newShip = null;
            if(shipType.equalsIgnoreCase('u')){
                return new UFOEnemyShip();
            }else if(shipType.equalsIgnoreCase('r')){
                return new RocketEnemyShip();
            }else if(shipType.equalsIgnoreCase('b')){
                return new BigUFOEnemyShip();
            }else{
                return null;
            }
        }
    }
    
    public class UFOEnemyShip extends EnemyShip{
        public UFOEnemyShip(){
            setName('UFO Ship');
            setAmtDamage(Double.valueOf(20.0));
        }
    }
    
    public class BigUFOEnemyShip extends EnemyShip{
        public BigUFOEnemyShip(){
            setName('Big UFO Ship');
            setAmtDamage(Double.valueOf(40.0));
        }
    }
    
    public class RocketEnemyShip extends EnemyShip{
        public RocketEnemyShip(){
            setName('Rocket Ship');
            setAmtDamage(Double.valueOf(10.0));
        }
    }
}
