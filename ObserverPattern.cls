public class ObserverPattern {
    
    public static void doStuff(){
        StockGrabber stockGrabber = new StockGrabber();
        StockObserver o1 = new StockObserver(stockGrabber);
        stockGrabber.setIBMPrice(Double.valueOf(198.00));
        stockGrabber.setAAPLPrice(Double.valueOf(194.00));
        stockGrabber.setGOOGPrice(Double.valueOf(195.00));


        StockObserver o2 = new StockObserver(stockGrabber);
        stockGrabber.setIBMPrice(Double.valueOf(198.00));
        stockGrabber.setAAPLPrice(Double.valueOf(194.00));
        stockGrabber.setGOOGPrice(Double.valueOf(195.00));
        
        stockGrabber.unregister(o1);
        stockGrabber.setIBMPrice(Double.valueOf(198.00));
        stockGrabber.setAAPLPrice(Double.valueOf(194.00));
        stockGrabber.setGOOGPrice(Double.valueOf(195.00));
        
        
    }

    
    public interface Subject{
        void register(Observer o);
        void unregister(Observer o);
        void notifyObserver();
    }
    
    public interface Observer{
        void updateStuff(Double ibmPrice, Double aaplPrice, Double googPrice);
    }
    
    public class StockObserver implements Observer{
        private Double ibmPrice;
        private Double aaplPrice;
        private Double googPrice;
        
        //this doesn't work unless this variable is static but salesforce does not 
        //allow lower level static variables....  just keep that in mind if it is 
        //actually implmented in real life.
        private Integer observerIdTracker = 0;
        
        private Integer observerId;
        private Subject stockGrabber;
        
        public StockObserver(Subject stockGrabber){
            this.stockGrabber = stockGrabber;
            this.observerId = ++observerIdTracker;
            
            stockGrabber.register(this);
        }
        
        public void updateStuff(Double ibmPrice, Double aaplPrice, Double googPrice){
            this.ibmPrice = ibmPrice;
            this.aaplPrice = aaplPrice;
            this.googPrice = googPrice;
            printThePrices();
        }
        
        public void printThePrices(){
            System.debug(observerId + ', IBM: ' + this.ibmPrice + ', Apple: ' + this.aaplPrice + ', Google: ' + this.googPrice);
        }
        
    }
    
    public class StockGrabber implements Subject{
        private List<Observer> observers;
        private Double ibmPrice;
        private Double aaplPrice;
        private Double googPrice;
        
        public StockGrabber(){
            observers = new List<Observer>();
        }
        
        public void register(Observer o){
            observers.add(o);
        }
        
        public void unregister(Observer o){
            for(Integer i = 0; i < observers.size(); i++){
                if(observers.get(i) == o){
                    observers.remove(i);
                    break;
                }                
            }
            
        }
        
        public void notifyObserver(){
            for(Observer o : observers){
                o.updateStuff(ibmPrice, aaplPrice, googPrice);
            }            
        }

        public void setIBMPrice(Double newPrice){
            this.ibmPrice = newPrice;
            notifyObserver();
        }
        
        public void setAAPLPrice(Double newPrice){
            this.aaplPrice = newPrice;
            notifyObserver();
        }
        
        public void setGOOGPrice(Double newPrice){
            this.googPrice = newPrice;
            notifyObserver();
        }
    }
}
