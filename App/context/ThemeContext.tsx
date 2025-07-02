import React, { createContext, useState, useContext, useEffect } from "react";
import { Appearance } from "react-native";
import AsyncStorage from "@react-native-async-storage/async-storage";

type Theme = "light" | "dark";

interface ThemeContextType {
  theme: Theme;
  toggleTheme: () => void;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

export const ThemeProvider = ({ children }: { children: React.ReactNode }) => {
  const [theme, setTheme] = useState<Theme>("dark"); // 👈 valeur par défaut forcée

  // Charger le thème sauvegardé
  useEffect(() => {
    const loadTheme = async () => {
      const stored = await AsyncStorage.getItem("theme");
      if (stored === "dark" || stored === "light") {
        setTheme(stored);
      } else {
        const system = Appearance.getColorScheme() || "dark";
        setTheme(system);
      }
    };
    loadTheme();
  }, []);

  // Sauvegarder quand le thème change
  useEffect(() => {
    AsyncStorage.setItem("theme", theme);
  }, [theme]);

  // Ne plus écouter system pour ne pas écraser le choix utilisateur
  // (si tu veux qu’il suive toujours le système, tu peux le remettre)

  const toggleTheme = () => {
    setTheme(prev => (prev === "light" ? "dark" : "light"));
  };

  return (
    <ThemeContext.Provider value={{ theme, toggleTheme }}>
      {children}
    </ThemeContext.Provider>
  );
};

export const useTheme = () => {
  const context = useContext(ThemeContext);
  if (!context) throw new Error("useTheme must be used inside ThemeProvider");
  return context;
};
