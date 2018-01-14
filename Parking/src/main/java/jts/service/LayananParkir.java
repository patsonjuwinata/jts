package jts.service;

import java.util.ArrayList;
import java.util.List;
import jts.model.Parkir;

public class LayananParkir {

	 public static List<Parkir> dataParkir = new ArrayList<Parkir>();
	 public static List<Integer> kapasitasParkir = new ArrayList<Integer>();
	 
	 public static void initKapasitasParkir() {
		 if (kapasitasParkir.size()<3) {
			 kapasitasParkir.clear();
			 kapasitasParkir.add(5);
			 kapasitasParkir.add(5);
			 kapasitasParkir.add(5);	
		 }
	 }
	 
	 public static List<Integer> getKapasitasParkir() {
		 return kapasitasParkir;
	 }

	 public static void tambahBaru(Parkir data) {
		 dataParkir.add(data);	
		 String lokasiParkir = data.getLokasiParkir();
		 switch (lokasiParkir) {
		 	case "Gedung A": int a = kapasitasParkir.get(0); a--; kapasitasParkir.set(0,a); break;
		 	case "Gedung B": int b = kapasitasParkir.get(1); b--; kapasitasParkir.set(1,b); break;
		 	case "Gedung C": int c = kapasitasParkir.get(2); c--; kapasitasParkir.set(2,c); break;
		 }
	 }
	
	 public static List<Parkir> getDataParkir() {
		 return dataParkir;
	 }

}

