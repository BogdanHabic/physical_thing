import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.ArrayList;
import java.awt.Graphics;

import javax.swing.JFrame;
import javax.swing.Timer;




public class Game extends JFrame {

	ArrayList<Cyrcle> targets;
	
	public Game() {
		
		targets = new ArrayList<>();
		setTitle("Target Practise");
		setSize(new Dimension(320, 240));
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setLocationRelativeTo(null);
		setVisible(true);
		
		addMouseListener(new MouseListener() {
			
			@Override
			public void mouseReleased(MouseEvent e) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void mousePressed(MouseEvent e) {
				// TODO Auto-generated method stub
				if(e.getButton() == MouseEvent.BUTTON1){
					targets.add(new Cyrcle(e.getX(), e.getY(), true));
					System.out.println("LEVI");
				}
				if(e.getButton() == MouseEvent.BUTTON3){
					targets.add(new Cyrcle(e.getX(), e.getY(), false));
					System.out.println("DESNI");
				}
				repaint();
			}
			
			@Override
			public void mouseExited(MouseEvent e) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void mouseEntered(MouseEvent e) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void mouseClicked(MouseEvent e) {
				// TODO Auto-generated method stub
				
			}
		});
		
		ActionListener thread = new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				for(Cyrcle c : targets) {
					c.time--;
				}
				repaint();
			}
		};
		new Timer(1000, thread).start();
	}


	public void paint(Graphics g) {

		super.paint(g);
		for(Cyrcle c : targets) {
			if(c.time <= 0) {
				continue;
			}
			if(c.real) {
				g.setColor(Color.GREEN);
			}else{
				g.setColor(Color.red);
			}
			g.drawOval(c.x - c.size/2, c.y - c.size/2, c.size, c.size);
			g.fillOval(c.x - c.size/2, c.y - c.size/2, c.size, c.size);
		}
	}
	
	public class Cyrcle {
		private int x;
		private int y;
		private int time;
		private int size;
		private boolean real;
		
		public Cyrcle(int x, int y, boolean real) {
			this.x = x;
			this.y = y;
			time = 3;
			size = 40;
			this.real = real;
		}
	}
	

}
