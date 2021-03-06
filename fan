package assign3_10203038;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.GridLayout;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.Shape;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.AdjustmentEvent;
import java.awt.event.AdjustmentListener;
import java.awt.image.ImageObserver;
import java.text.AttributedCharacterIterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JApplet;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollBar;

public class Assign3_10203038 extends JFrame {

private JButton start = new JButton("Start");
private JButton stop = new JButton("Stop");
private JButton reverse = new JButton("Reverse");
private JScrollBar speed = new JScrollBar();
private Thread timer;
private final ArcsPanel arcs;

 public Assign3_10203038() {
    arcs = new ArcsPanel();

    JPanel p = new JPanel();
    p.setSize(5000, 5000);
    p.add(arcs);
    p.add(start);
    p.add(stop);
    p.add(reverse);
    p.add(speed);
    p.setLayout(new GridLayout());
    add(p);

    start.addActionListener(new ActionListener() {
        @Override
        public void actionPerformed(ActionEvent e) {
            timer = new Thread(arcs);
            timer.start();


        }
    });

    speed.addAdjustmentListener(new AdjustmentListener() {
        public void adjustmentValueChanged(AdjustmentEvent ae) {
            System.out.println(ae.getValue());
            arcs.speed(ae.getValue());
        }
    });


    reverse.addActionListener(new ActionListener() {
        public void actionPerformed(ActionEvent e) {
            arcs.reverse();

        }
    });

    stop.addActionListener(new ActionListener() {
        public void actionPerformed(ActionEvent e) {
            timer.stop();
        }
    });
}

public static void main(String[] args) {
    Assign3_10203038 window = new Assign3_10203038();

    //  (new Thread(window)).start();
    window.setSize(500, 500);

    window.setLocation(50, 50); // Center the frame
    //  window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    window.setVisible(true);
}
}

class ArcsPanel extends JPanel implements Runnable {
// Draw four blades of a fan

int thr = 1000;
int i = -20;

public void run() {
    while (true) {
        starting_x = (starting_x + i) % 360;
        repaint();
        try {
            Thread.sleep(thr);
        } catch (InterruptedException ex) {
            Logger.getLogger(Assign3_10203038.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}

public void reverse() {
    i = -i;
}

 public void speed(int p) {
    thr = 1000 - (p += p) * 5;

 }
 int starting_x;

 public void initializex(int x_val) {
    starting_x = x_val;
 }

 public void paintComponent(Graphics g) {
    super.paintComponent(g);

    int xCenter = getWidth() / 2;
    int yCenter = getHeight() / 2;
    int radius = (int) (Math.min(getWidth(), getHeight()) * 0.4);


 int x = xCenter - radius;
int y = yCenter - radius;

{
g.fillArc(x, y, 2 * radius, 2 * radius, 0 + starting_x, 30);
g.fillArc(x, y, 2 * radius, 2 * radius, 90 + starting_x, 30);
g.fillArc(x, y, 2 * radius, 2 * radius, 180 + starting_x, 30);
g.fillArc(x, y, 2 * radius, 2 * radius, 270 + starting_x, 30);

}

}
}
