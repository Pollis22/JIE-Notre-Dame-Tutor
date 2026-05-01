import { useLocation } from "wouter";
import ndLogo from "@/assets/notre-dame-logo.png";

export function Footer() {
  const [, setLocation] = useLocation();
  const year = new Date().getFullYear();

  return (
    <footer style={{ background: "#FFFFFF", borderTop: "1px solid #E8E8E8", padding: "32px 0", marginTop: "auto" }}>
      <div className="container mx-auto px-4">
        <div className="flex flex-col md:flex-row justify-between items-center gap-4 mb-4">
          <div className="flex flex-wrap justify-center md:justify-start gap-6">
            <button onClick={() => setLocation("/terms")} className="text-sm hover:underline" style={{ color: "#C99700", background: "none", border: "none", cursor: "pointer" }}>
              Terms & Conditions
            </button>
            <button onClick={() => setLocation("/privacy")} className="text-sm hover:underline" style={{ color: "#C99700", background: "none", border: "none", cursor: "pointer" }}>
              Privacy Policy
            </button>
          </div>
        </div>

        <div className="flex flex-col md:flex-row justify-between items-center gap-3 pt-4" style={{ borderTop: "1px solid #E8E8E8" }}>
          <div className="flex items-center gap-3">
            <img src={ndLogo} alt="University of Notre Dame" style={{ height: 32 }} />
            <span style={{ fontSize: 13, color: "#0C2340", fontWeight: 600 }}>
              University of Notre Dame · AI Tutor Program
            </span>
          </div>
          <span style={{ fontSize: 12, color: "#8c7535" }}>
            © {year} University of Notre Dame du Lac. All rights reserved.
          </span>
        </div>

        {/* Notre Dame trademark notice */}
        <div className="mt-4 pt-4" style={{ borderTop: "1px dashed #E8E8E8" }}>
          <p style={{ fontSize: 11, color: "#6b6b6b", lineHeight: 1.5, textAlign: "center", maxWidth: 900, margin: "0 auto" }}>
            The University of Notre Dame name, monogram, Fighting Irish, Touchdown Jesus, and Golden Dome are
            trademarks of the University of Notre Dame du Lac, used under license for this exclusive deployment.
          </p>
          <p style={{ fontSize: 11, color: "#999999", lineHeight: 1.5, textAlign: "center", marginTop: 6 }}>
            Powered by <a href="https://jiemastery.ai" target="_blank" rel="noopener noreferrer"
              style={{ color: "#C99700", textDecoration: "none", fontWeight: 600 }}>
              JIE Mastery.ai
            </a>
          </p>
        </div>
      </div>
    </footer>
  );
}
