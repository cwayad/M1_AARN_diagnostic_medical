package apprentissage;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

public class test {
	Scanner e = new Scanner(System.in);

	public static void main(String[] args) throws IOException {
		String path = "src/NN_InPut.txt";
		String cible = "src/NN_InPutNorm.txt";
		String[] parts;
		float min = 1, max = 1,var;
		int x = 111; //nombre de colonnes
		float[] tableau = new float[x];
		Scanner reader = new Scanner(new File(path));
		BufferedWriter writer = new BufferedWriter(new FileWriter(new File(
				cible)));
		while (reader.hasNextLine()) {
			try {
				String line = reader.nextLine();
				parts = line.split("\t+");
				for (int i = 0; i < x; i++) {
					tableau[i] = Integer.parseInt(parts[i]);
				}

				for (int i = 0; i < x; i++) {
					if (tableau[i] < min) {
						min = tableau[i];
					}
					if (tableau[i] > max) {
						max = tableau[i];
					}
				}
			} catch (NumberFormatException ex) {
				System.out.println(" Erreur! parse impossible ! ");
			}
		}
		reader.close();
		reader = new Scanner(new File(path));
		while (reader.hasNextLine()) {
			try {
				String line = reader.nextLine();
				parts = line.split("\t");
				for (int i = 0; i < x; i++) {
					tableau[i] = Integer.parseInt(parts[i]);
				}
				for (int i = 0; i < x; i++) {
					var = (tableau[i] - min) / (max - min);
					writer.write(Float.toString(var) + "\t");
				}
				writer.newLine();

			} catch (NumberFormatException ex) {
				System.out.println(" Erreur! parse impossible ! ");
			}
		}
		writer.close();
	}

}