let leftPaddle;
let rightPaddle;
let ball;
let leftScore = 0;
let rightScore = 0;
let backgroundImage;

function preload() {
   
  backgroundImage = loadImage('https://static.wikia.nocookie.net/finalfantasy/images/0/0e/DFFNT_Akademeia_Webphoto_2.png/revision/latest?cb=20180614033012'); 
}
function setup() {
  createCanvas(600, 400);
  
  leftPaddle = new Paddle(20, height / 2);
  rightPaddle = new Paddle(width - 20, height / 2);
  ball = new Ball();
}

function draw() {
  background(backgroundImage);
  
  
  fill(255);
  textSize(32);
  textAlign(CENTER);
  text(leftScore, width / 4, 50);
  text(rightScore, 3 * width / 4, 50);
  
  
  leftPaddle.update();
  rightPaddle.update();
  ball.update();
  leftPaddle.show();
  rightPaddle.show();
  ball.show();
  
  
  if (ball.hits(leftPaddle) || ball.hits(rightPaddle)) {
    ball.xSpeed *= -1;
  }
  
  
  if (ball.isOutOfBounds()) {
    if (ball.x < 0) {
      rightScore++;
    } else {
      leftScore++;
    }
    ball.reset();
  }
}


class Paddle {
  constructor(x, y) {
    this.x = x;
    this.y = y;
    this.w = 20;
    this.h = 100;
  }
  
  update() {
    
    if (keyIsDown(UP_ARROW)) {
      this.y -= 5;
    } else if (keyIsDown(DOWN_ARROW)) {
      this.y += 5;
    }
    
    
    this.y = constrain(this.y, this.h / 2, height - this.h / 2);
  }
  
  show() {
    fill(255);
    rectMode(CENTER);
    rect(this.x, this.y, this.w, this.h);
  }
}


class Ball {
  constructor() {
    this.reset();
    this.size = 20;
    this.xSpeed = 5;
    this.ySpeed = 5;
  }
  
  update() {
    this.x += this.xSpeed;
    this.y += this.ySpeed;
    
    
    if (this.y < 0 || this.y > height) {
      this.ySpeed *= -1;
    }
  }
  
  show() {
    fill(255);
    ellipse(this.x, this.y, this.size);
  }
  
  hits(paddle) {
    
    return (
      this.x - this.size / 2 < paddle.x + paddle.w / 2 &&
      this.x + this.size / 2 > paddle.x - paddle.w / 2 &&
      this.y - this.size / 2 < paddle.y + paddle.h / 2 &&
      this.y + this.size / 2 > paddle.y - paddle.h / 2
    );
  }
  
  isOutOfBounds() {
    
    return this.x < 0 || this.x > width;
  }
  
  reset() {
    
    this.x = width / 2;
    this.y = height / 2;
  }
}