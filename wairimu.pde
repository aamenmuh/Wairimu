char nodeValues[] = {'H','a','b','i','b','i',',','w','i','l','l','y','o','u','g','o','t','o','p','r','o','m', 'w','i','t','h','m','e'};
char scrambledList[] = {'H','a','b','i','b','i',',','w','i','l','l','y','o','u','g','o','t','o','p','r','o','m', 'w','i','t','h','m','e'};
int nodePointers[] = {4, 18, 2, 17, 3, 11, 24, 6, 8, 26, 10, 14, 12, 7, 9, 23, 25, 15, 27, 20, 5, 22, 1, 19, 13, 21};
int startPointer = 0;
int endPointer = -1;
int positions[][] = new int [28][2];
int rectWidth = 200;
int rectHeight = 100;
int inBetween;
int i;
int rectX, rectY;
int inBetweenY = 150;
int currentIndex, prevIndex;
String phrase;
void drawListNode(char node, int index){
  rectX = ((index + 1) % 5) * (width /5) + inBetween;
  rectY = ((index + 1) / 5) * inBetweenY + inBetween;
  rect(rectX,rectY,rectWidth,rectHeight);
  textSize(60);
  fill(0);
  text(node, rectX,rectY + 65);
  fill(255);
}

void drawArrow(float x,float y, float len, float angle){
  //angle+=0.1;
  pushMatrix();
  translate(x,y);
  rotate(angle < 0? angle: angle);
  line(0,0,len,0);
  line(len,0,len-8,-8);
  line(len,0,len - 8, 8);
  popMatrix();
}

void drawEdgeCircle(float x, float y, float r,String s){
  circle(x, y, r);
  textSize(60);
  fill(0);
  text(s, x-60,y + 20);
  fill(255);
}

void setup(){
  //size(displayWidth - 100, displayHeight - 100);
  //windowMove(width/2, height/2);
  currentIndex = startPointer;
  fullScreen();
  inBetween = (width - 5 * rectWidth) / 20;
  
  for (int j = 0; j < 28; j++){
   positions[j][0] = ((j + 1) % 5) * (width /5) + inBetween;
   positions[j][1] = ((j + 1) / 5) * inBetweenY + inBetween;
  }
  
  for (int j = 0 ; j < 26; j++){
    int currentIndex = nodePointers[j];
    scrambledList[currentIndex] = nodeValues[j + 1];
    //print(currentIndex, ": ", scrambledList[currentIndex], ", ");
  }
  scrambledList[startPointer] = 'H';
  
  //drawEdgeCircle(inBetween + rectWidth / 2, inBetween + rectHeight/2, 150,"Start");
  for (int j = 0; j < 28; j++){
    drawListNode(scrambledList[j],j);
    print(scrambledList[j], ", ");
  }
  //drawEdgeCircle(width - (inBetween + rectWidth / 2) - rectWidth / 2 - 20 ,height - (inBetween + rectHeight/2)  - rectHeight - 40, 150,"End");
  print('\n');
  phrase = "";
}
void draw(){
  if (i < 26){
  phrase += scrambledList[prevIndex];
  int nextIndex = nodePointers[currentIndex];
  rectX = positions[prevIndex][0];
  rectY = positions[prevIndex][1];
  float rectXEnd = positions[nextIndex][0] - rectWidth;
  float rectYEnd = positions[nextIndex][1];
  float distY = rectYEnd - rectY;
  float distX = rectXEnd - rectX;
  float dist = sqrt(distX * distX + distY* distY);
  float theta = atan2(distY, distX);
  //println(dist);
  //println(theta);
  print(scrambledList[currentIndex], ", ", scrambledList[nextIndex], "\n");
  drawArrow(rectX + rectWidth,rectY + rectHeight/2,dist , theta);
  //println(theta);
  currentIndex += 1;
  prevIndex = nextIndex;
  //delay(5000);
  //println(nodeValues[i]);
  i++;
  textSize(60);
  fill(0);
  text(phrase, 30, height - 30);
  if (i == 7 || i == 11 || i == 14 || i == 16 || i == 18 || i == 22 || i == 26)
    phrase += " ";
  }
    if (i == 26){
      phrase += "m";
      text(phrase, 30, height - 30);
      i++;
    }
  delay(200);
  if(i == 27){
    phrase += "e?";
    text(phrase, 30, height - 30);
    i++;
  }
  println(i);
}
