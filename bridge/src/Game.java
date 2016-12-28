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

import com.sun.javafx.geom.Ellipse2D;




public class Game extends JFrame {

	ArrayList<Cyrcle> targets;
	int points = 0;
	
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
				}
				if(e.getButton() == MouseEvent.BUTTON3){
					targets.add(new Cyrcle(e.getX(), e.getY(), false));
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
				ArrayList<Cyrcle> remove = new ArrayList<>();
				for(Cyrcle c : targets) {
					c.time--;
					if(c.time <= 0) {
						remove.add(c);
						repaint();
					}
				}
				targets.removeAll(remove);
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
	
	public void check(int x, int y) {
		ArrayList<Cyrcle> remove = new ArrayList<>();
		for(Cyrcle c : targets) {
			if (!c.contains(x, y)) {
				continue;
			}
			
			points += c.real ? 1 : -3;
			
			remove.add(c);
		}
		targets.removeAll(remove);
		repaint();
		System.out.println(points);
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
		
		public boolean contains(int x, int y) {
			Ellipse2D ell = new Ellipse2D(x - 20, y - 20, 40, 40);
			
			System.out.println(x);
			System.out.println(y);
			System.out.println(ell.x+20);
			System.out.println(ell.y+20);
			System.out.println(ell.contains(x, y));
			
			return ell.contains(x,  y);
		}

		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + getOuterType().hashCode();
			result = prime * result + (real ? 1231 : 1237);
			result = prime * result + x;
			result = prime * result + y;
			return result;
		}

		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			Cyrcle other = (Cyrcle) obj;
			if (!getOuterType().equals(other.getOuterType()))
				return false;
			if (real != other.real)
				return false;
			if (x != other.x)
				return false;
			if (y != other.y)
				return false;
			return true;
		}

		private Game getOuterType() {
			return Game.this;
		}
		
	}
}
