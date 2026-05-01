import { useState, useEffect } from "react";
import ndLogo from "@/assets/notre-dame-logo.png";
import ndClassroom from "@/assets/campus/nd-classroom.png";
import goldenDomeCloseup from "@/assets/campus/golden-dome-closeup.png";
import ndGraduation from "@/assets/campus/nd-graduation.png";
import goldenDome from "@/assets/campus/golden-dome.png";
import leprechaunStatue from "@/assets/campus/leprechaun-statue.png";
import irishFans from "@/assets/campus/irish-fans.png";
import touchdownJesus from "@/assets/campus/touchdown-jesus.png";
import hesburghReflection from "@/assets/campus/hesburgh-reflection.png";

// Notre Dame brand colors
const ND_BLUE  = "#0C2340";   // Notre Dame Blue (PMS 289)
const ND_GOLD  = "#C99700";   // Standard Dome Gold (PMS 117)
const ND_NAVY  = "#1e2a47";   // deeper navy variant for gradients
const ND_INK   = "#0a2240";   // near-black ink variant

const STATS = [
  { value: "Academic SRM", label: "+ AI Tutor" },
  { value: "Syllabus-Aware", label: "Every Session" },
  { value: "25+ Subjects", label: "Covered" },
  { value: "24/7", label: "Available" },
];

const COURSES = [
  "Calculus", "Biology", "Chemistry", "History", "English",
  "Economics", "Physics", "Statistics", "Political Science", "Psychology",
  "Sociology", "Accounting", "Kinesiology", "Genetics", "Philosophy",
];

interface Props {
  /** Hide when a tutoring session is active */
  mounted?: boolean;
}

export function HeroBanner({ mounted = false }: Props) {
  const [activeSlide, setActiveSlide] = useState(0);
  const [tick, setTick]               = useState(0);

  // SRM-first messaging — 8 rotating slides, Notre Dame Fighting Irish imagery throughout.
  // Each slide carries its own objectPosition so faces/heads stay in frame
  // when the image is cropped into the wide slideshow container.
  const slides = [
    {
      image:    touchdownJesus,
      headline: "Your Academic Command Center",
      sub:      "Student Relationship Manager + AI Tutor, built for Fighting Irish",
      accent:   ND_INK,
      position: "center 25%",
    },
    {
      image:    goldenDome,
      headline: "One System. Every Course. Every Deadline.",
      sub:      "Syllabus → calendar → study tasks → tutor — automatically",
      accent:   ND_NAVY,
      position: "center 55%",
    },
    {
      image:    ndGraduation,
      headline: "Stay Ahead, All the Way to the Podium",
      sub:      "Engagement scoring and early alerts keep you on track",
      accent:   ND_BLUE,
      position: "center 30%",
    },
    {
      image:    ndClassroom,
      headline: "A Tutor That Knows Your Semester",
      sub:      "Every session opens already knowing what's due next",
      accent:   ND_BLUE,
      position: "center 35%",
    },
    {
      image:    goldenDomeCloseup,
      headline: "Learn at Your Own Pace",
      sub:      "Adaptive instruction across every course and subject",
      accent:   ND_INK,
      position: "center 35%",
    },
    {
      image:    hesburghReflection,
      headline: "From the Golden Dome to the Hesburgh Library",
      sub:      "Study anywhere — voice, text, any device",
      accent:   ND_NAVY,
      position: "center center",
    },
    {
      image:    leprechaunStatue,
      headline: "Built for Student-Athletes",
      sub:      "Travel-ready tutoring with eligibility-protecting alerts",
      accent:   ND_BLUE,
      position: "center 25%",
    },
    {
      image:    irishFans,
      headline: "Go Irish.",
      sub:      "Academic support built for University of Notre Dame students",
      accent:   ND_BLUE,
      position: "center 25%",
    },
  ];

  useEffect(() => {
    const t = setInterval(() => setActiveSlide(p => (p + 1) % slides.length), 5000);
    return () => clearInterval(t);
  }, [slides.length]);

  useEffect(() => {
    const t = setInterval(() => setTick(p => p + 1), 80);
    return () => clearInterval(t);
  }, []);

  if (mounted) return null;

  const courseIndex = Math.floor(tick / 30) % COURSES.length;

  return (
    <div className="w-full rounded-2xl overflow-hidden mb-2" style={{ fontFamily: "'Segoe UI', system-ui, sans-serif" }}>

      {/* ── Hero Slideshow ─────────────────────────────────── */}
      <div
        className="relative w-full overflow-hidden"
        style={{
          // Taller than the old 180px so faces/heads don't get cropped.
          // Scales with viewport: min 220px on phones, up to 340px on wide desktops.
          height: "clamp(220px, 26vw, 340px)",
          borderRadius: "16px 16px 0 0",
        }}
      >
        {slides.map((slide, i) => (
          <div
            key={i}
            className="absolute inset-0 transition-all duration-1000"
            style={{
              opacity:   activeSlide === i ? 1 : 0,
              transform: activeSlide === i ? "scale(1)" : "scale(1.03)",
            }}
          >
            <img
              src={slide.image}
              alt=""
              className="absolute inset-0 w-full h-full object-cover"
              style={{ objectPosition: slide.position }}
            />
            <div
              className="absolute inset-0"
              style={{ background: `linear-gradient(105deg, ${slide.accent}ee 0%, ${slide.accent}99 38%, transparent 68%)` }}
            />
            <div className="absolute inset-0 flex flex-col justify-center pl-6 pr-40">
              {/* Badge */}
              <div
                className="inline-flex items-center gap-2 mb-2 px-2 py-0.5 rounded-full w-fit"
                style={{ background: "rgba(255,255,255,0.18)", backdropFilter: "blur(6px)" }}
              >
                <img src={ndLogo} alt="" className="h-5 w-auto" style={{ filter: "brightness(0) invert(1)" }} />
                <span className="text-white text-xs font-bold tracking-widest uppercase">University of Notre Dame</span>
              </div>
              <h2
                className="text-white font-black leading-tight mb-1"
                style={{ fontSize: "1.35rem", textShadow: "0 2px 12px rgba(0,0,0,0.45)" }}
              >
                {slide.headline}
              </h2>
              <p className="text-white/85 text-sm font-medium" style={{ textShadow: "0 1px 6px rgba(0,0,0,0.3)" }}>
                {slide.sub}
              </p>
            </div>
          </div>
        ))}

        {/* Slide dots */}
        <div className="absolute bottom-3 right-4 flex gap-1.5 z-10">
          {slides.map((_, i) => (
            <button
              key={i}
              onClick={() => setActiveSlide(i)}
              style={{
                width:        activeSlide === i ? 20 : 6,
                height:       6,
                borderRadius: 3,
                background:   activeSlide === i ? "white" : "rgba(255,255,255,0.45)",
                border:       "none",
                cursor:       "pointer",
                padding:      0,
                transition:   "all 0.3s ease",
              }}
            />
          ))}
        </div>
      </div>

      {/* ── Stats Strip ────────────────────────────────────── */}
      <div
        className="grid grid-cols-4 w-full"
        style={{ background: `linear-gradient(90deg, ${ND_BLUE} 0%, ${ND_NAVY} 100%)` }}
      >
        {STATS.map((stat, i) => (
          <div
            key={i}
            className="flex flex-col items-center justify-center py-2.5"
            style={{ borderRight: i < STATS.length - 1 ? "1px solid rgba(255,255,255,0.2)" : "none" }}
          >
            <span className="text-white font-black leading-none" style={{ fontSize: "0.95rem" }}>
              {stat.value}
            </span>
            <span className="text-white/75 text-xs mt-0.5 font-medium tracking-wide">
              {stat.label}
            </span>
          </div>
        ))}
      </div>

      {/* ── Course Ticker ──────────────────────────────────── */}
      <div
        className="flex items-center gap-0 w-full overflow-hidden"
        style={{ background: ND_NAVY, borderRadius: "0 0 16px 16px", padding: "7px 16px" }}
      >
        <span className="text-xs font-bold uppercase tracking-widest mr-3 shrink-0" style={{ color: ND_GOLD }}>
          Courses
        </span>
        <div className="flex gap-2 overflow-hidden flex-1">
          {COURSES.map((course, i) => {
            const isActive = i === courseIndex;
            const isNear   = Math.abs(i - courseIndex) <= 2;
            return (
              <span
                key={course}
                className="text-xs font-semibold whitespace-nowrap transition-all duration-500 px-2 py-0.5 rounded-full shrink-0"
                style={{
                  background: isActive ? ND_BLUE : isNear ? "rgba(12,35,64,0.18)" : "transparent",
                  color:      isActive ? "white" : isNear ? "rgba(255,255,255,0.8)" : "rgba(255,255,255,0.32)",
                  transform:  isActive ? "scale(1.1)" : "scale(1)",
                }}
              >
                {course}
              </span>
            );
          })}
        </div>
      </div>
    </div>
  );
}
