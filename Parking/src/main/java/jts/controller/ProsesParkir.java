package jts.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import jts.model.Parkir;
import jts.service.LayananParkir;

@Controller
public class ProsesParkir {

	@RequestMapping(value = "/tambah", method = RequestMethod.GET)
	public ModelAndView formParkir(HttpServletRequest request, HttpServletResponse response) {
		LayananParkir.initKapasitasParkir();
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("kapasitasParkir",LayananParkir.getKapasitasParkir());
		List<Parkir> dataParkir = LayananParkir.getDataParkir();
		String semua = "";
		for (Parkir item : dataParkir) {
			 semua += semua.length()==0 ? item.getNoPlatKendaraan() : "|"+item.getNoPlatKendaraan();
	    }
		data.put("dataParkir",semua);
		ModelAndView mv = new ModelAndView("tambah","data",data);
		mv.addObject("parkir",new Parkir());
		return mv;
	}
	  
	@RequestMapping(value = "/prosesParkir", method = RequestMethod.POST)
	public ModelAndView prosesParkir(HttpServletRequest request, HttpServletResponse response,
	@ModelAttribute("parkir") Parkir parkir) {
		LayananParkir.tambahBaru(parkir);
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("noPlatKendaraan",parkir.getNoPlatKendaraan());
		data.put("lokasiParkir",parkir.getLokasiParkir());
		data.put("dataParkir",LayananParkir.getDataParkir());
		return new ModelAndView("sukses","data",data);
	}
	  
	@RequestMapping(value = "/lihat", method = RequestMethod.GET)
	public ModelAndView lihatSemua(HttpServletRequest request, HttpServletResponse response) {
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("dataParkir",LayananParkir.getDataParkir());
		return new ModelAndView("lihat","data",data);
	}

	@RequestMapping(value = "/hapus", method = RequestMethod.GET)
	public ModelAndView hapus(HttpServletRequest request, HttpServletResponse response) {
		String noPlat = request.getParameter("noplat");
		List<Parkir> dataParkir = LayananParkir.getDataParkir();
		int j = -1;
		String s = "";
		for (int i=0; i<dataParkir.size(); i++) {
			if (dataParkir.get(i).getNoPlatKendaraan().equals(noPlat)) {
				j = i;
				s = dataParkir.get(i).getLokasiParkir();
				break;
			}
	    }	
		if (j>-1) {
			LayananParkir.dataParkir.remove(j);
			switch (s) {
				case "Gedung A" : int a = LayananParkir.getKapasitasParkir().get(0); a++; LayananParkir.kapasitasParkir.set(0,a);
				case "Gedung B" : int b = LayananParkir.getKapasitasParkir().get(1); b++; LayananParkir.kapasitasParkir.set(1,b);
				case "Gedung C" : int c = LayananParkir.getKapasitasParkir().get(2); c++; LayananParkir.kapasitasParkir.set(2,c);
			}
		}
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("dataParkir",LayananParkir.getDataParkir());
		return new ModelAndView("lihat","data",data);
	}
	
}




