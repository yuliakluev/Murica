/*
 * 'Merica
 * 2017-18.S2
 */
import java.util.Scanner;
import java.util.StringTokenizer;

final static String[] FILE_NAMES_ELECTIONS = {
  "USA1960.txt", "USA1964.txt", "USA1968.txt", "USA1972.txt", "USA1976.txt", 
  "USA1980.txt", "USA1984.txt", "USA1988.txt", "USA1992.txt", "USA1996.txt", 
  "USA2000.txt", "USA2004.txt", "USA2008.txt", "USA2012.txt", "USA2016.txt"
};

int value;
String fileName;
String[][] electionResults;


/*
 * SETUP; CALLED ONCE @ STARTUP
 */
 
 int fileNum = 0;
void setup() {

  size( 1200, 600 );

  // DEFAULT MAP
  
  fileName = FILE_NAMES_ELECTIONS[fileNum];

  // ELECTION RESULTS
  electionResult();
  
}

/*
 * ELECTION RESULTS
 * - parse election file INTO electionResults[][] 2D-Array, or data structure of your choice.
 */
void electionResult( ) {
  try {
    
    
    // ELECTION RESULT DATA
    Scanner data = new Scanner( new File( dataPath("") + "\\" + fileName ) );
    
    electionResults = new String[51][4];
    
    // SKIP FIRST LINE
    data.nextLine();
    
    int state = 0;
    //filling out state election data
    while(data.hasNextLine() ) {
     
      StringTokenizer st = new StringTokenizer( data.nextLine(), "," );
      
      electionResults[state][0] = st.nextToken();
      electionResults[state][1] = st.nextToken();
      electionResults[state][2] = st.nextToken();
      electionResults[state][3] = st.nextToken();
      state++;
    }
    
    
    data.close();
    
    
    drawMap();

    
  }
  catch (Exception e ) {
    e.printStackTrace();
  }
}

/*
 * DRAW MAP OFF USA w/ Election Results
 */
void drawMap() {
  // MAP
  try {
    background(66, 179, 244);
    textSize(45);
    fill(255);
    text(FILE_NAMES_ELECTIONS[fileNum].substring(3,7),200, 500);
   
    
    float x, y;
    
    // USA MAP DATA
    File file =new File( dataPath("") + "\\USA.txt" );
    Scanner data = new Scanner( file  );


    // MIN (x,y)
    StringTokenizer st = new StringTokenizer( data.nextLine() );
    float minX = Float.parseFloat(st.nextToken());
    float minY = Float.parseFloat(st.nextToken());
    
    // MAX (x,y)
    st = new StringTokenizer( data.nextLine() );
    float maxX = Float.parseFloat(st.nextToken());
    float maxY = Float.parseFloat(st.nextToken());

    int stretchX = 18;
    int stretchY =18;
    float translateX = (1200 - (stretchX*(maxX - minX)))/2;
    float translateY = (600 - (stretchY*(maxY- minY)))/2;
    
    // # of Regions
    int regions = Integer.parseInt( data.nextLine()) ;
    

    
    // LOOP THROUGH REGIONS
    for( int r = 0; r < regions; r++ ) {
          // SKIP BLANK LINE
    data.nextLine();
      //STATE
      String state = data.nextLine();
      
      
      data.nextLine();
      int numOfCoord = Integer.parseInt( data.nextLine() ) ;
      
      // COLOUR BASED ON STATE; LOOK IN ARRAY FOR 'state';
      gradientFill(state, electionResults, fileName);
      
      beginShape();
      for( int i = 0; i < numOfCoord; i++ ) {
        st = new StringTokenizer( data.nextLine());
        x =  (stretchX*(Float.parseFloat(st.nextToken()) - minX))+ translateX;
        y =  stretchY*(maxY - Float.parseFloat(st.nextToken())) + translateY;
        
        // TRANSLATE, STRETCH
        
        vertex( x, y );
        
        
        
      }
      endShape();
      
    }

    data.close();
  }
  catch (Exception e ) {
    e.printStackTrace();
  }
}

/*
 * Draw State
 */
public void solidFill(String state, String[][] electionResults , String fileName) {
    //FIND STATE IN ARRAY
    int i = 0;
    
   if( fileName.equals("USA1960.txt") && state.equals("District of Columbia")){
        
          fill( 255, 255, 255 );
       
    }
     
    else{
      while( !state.equals(electionResults[i][0])){
      i++;
    }
    
      
      if(Integer.parseInt(electionResults[i][1]) > Integer.parseInt(electionResults[i][2])){
       fill( 255, 0, 0 );
    }
      if(Integer.parseInt(electionResults[i][1]) < Integer.parseInt(electionResults[i][2])){
        fill( 0, 0, 255 );
    }
      if(Integer.parseInt(electionResults[i][1]) < Integer.parseInt(electionResults[i][3]) || Integer.parseInt(electionResults[i][2]) < Integer.parseInt(electionResults[i][3])){
       fill( 0, 255, 0 );
    }
    }

    
}
public void gradientFill(String state, String[][] electionResults , String fileName){
  
  int i = 0;
  int seatSum;
  
   if( fileName.equals("USA1960.txt") && state.equals("District of Columbia")){
          fill( 255, 255, 255 );
    }
    
   else{
     
      while( !state.equals(electionResults[i][0])){
      i++;
    }
      seatSum =  Integer.parseInt(electionResults[i][1]) + Integer.parseInt(electionResults[i][2]) + Integer.parseInt(electionResults[i][3]);
      fill(255*(Float.valueOf(electionResults[i][1])/seatSum) , 255*(Float.valueOf(electionResults[i][3])/seatSum), 255*(Float.valueOf(electionResults[i][2])/seatSum));
     
   }
    
}


void draw() {}
 

/*
 */
void keyPressed() {
  if(key == CODED){
   if(keyCode == LEFT){
 
     if( fileNum == 0){
       fileNum = 14; 
     }
     
     fileName = FILE_NAMES_ELECTIONS[--fileNum];
   }
   
   if(keyCode == RIGHT){
     
     if( fileNum == 14){
       fileNum = 0; 
     }
   
     fileName = FILE_NAMES_ELECTIONS[++fileNum];
   }
  }
    electionResult();
  }
//}