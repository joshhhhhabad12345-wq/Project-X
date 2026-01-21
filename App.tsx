
import React, { useState, useEffect } from 'react';
import { 
  ShieldAlert, 
  Zap, 
  Terminal, 
  MessageSquare, 
  ExternalLink, 
  Copy, 
  Check, 
  ChevronRight, 
  Video,
  Flame,
  Crown
} from 'lucide-react';

// --- Types ---
type Page = 'home' | 'script' | 'community';

// --- Components ---

const Navbar: React.FC<{ currentPage: Page; setPage: (p: Page) => void }> = ({ currentPage, setPage }) => {
  return (
    <nav className="fixed top-0 left-0 w-full z-50 bg-black/80 backdrop-blur-md border-b border-red-900/30 px-6 py-4 flex justify-between items-center">
      <div 
        className="flex items-center gap-2 cursor-pointer group"
        onClick={() => setPage('home')}
      >
        <div className="w-10 h-10 bg-red-600 rounded-full flex items-center justify-center box-glow-red group-hover:scale-110 transition-transform">
          <span className="font-goddess font-bold text-xl text-black">X</span>
        </div>
        <span className="font-goddess text-2xl font-black tracking-tighter glow-red text-red-600">PROJECT X</span>
      </div>
      
      <div className="hidden md:flex gap-8 items-center font-tech uppercase tracking-widest text-sm">
        <button 
          onClick={() => setPage('home')}
          className={`${currentPage === 'home' ? 'text-red-500 underline decoration-red-500 underline-offset-8' : 'text-gray-400 hover:text-white'} transition-colors`}
        >
          Overview
        </button>
        <button 
          onClick={() => setPage('script')}
          className={`${currentPage === 'script' ? 'text-red-500 underline decoration-red-500 underline-offset-8' : 'text-gray-400 hover:text-white'} transition-colors`}
        >
          Access Script
        </button>
        <button 
          onClick={() => setPage('community')}
          className={`${currentPage === 'community' ? 'text-red-500 underline decoration-red-500 underline-offset-8' : 'text-gray-400 hover:text-white'} transition-colors`}
        >
          Community
        </button>
      </div>

      <button 
        onClick={() => setPage('script')}
        className="px-5 py-2 bg-red-600 text-black font-bold text-xs rounded-sm box-glow-red hover:bg-red-500 transition-all uppercase tracking-widest font-tech"
      >
        Get Key
      </button>
    </nav>
  );
};

const HeroSection: React.FC<{ onNext: () => void }> = ({ onNext }) => {
  return (
    <section className="min-h-screen flex flex-col items-center justify-center px-4 relative overflow-hidden bg-radial-gradient">
      {/* Background Decor */}
      <div className="absolute top-1/4 -left-20 w-96 h-96 bg-red-900/20 rounded-full blur-[120px] pointer-events-none"></div>
      <div className="absolute bottom-1/4 -right-20 w-96 h-96 bg-red-900/20 rounded-full blur-[120px] pointer-events-none"></div>
      
      <div className="z-10 text-center max-w-4xl">
        <div className="inline-flex items-center gap-2 px-3 py-1 border border-red-500/50 rounded-full text-red-500 font-tech text-[10px] tracking-[0.2em] uppercase mb-6 bg-red-500/10">
          <Crown size={12} /> The Goddess Standard of Exploitation
        </div>
        <h1 className="font-goddess text-6xl md:text-9xl font-black mb-6 leading-tight">
          <span className="block text-white">ASCEND TO</span>
          <span className="text-red-600 glow-red drop-shadow-[0_0_20px_rgba(220,0,0,0.8)]">PROJECT X</span>
        </h1>
        <p className="text-gray-400 font-light text-lg md:text-xl mb-10 max-w-2xl mx-auto leading-relaxed">
          The ultimate utility suite for high-stakes combat. Engineered with precision, 
          adorned with power, and built for those who refuse to lose.
        </p>
        
        <div className="flex flex-col md:flex-row gap-4 justify-center items-center">
          <button 
            onClick={onNext}
            className="group px-8 py-4 bg-red-600 text-black font-black text-lg rounded-sm box-glow-red hover:bg-red-500 transition-all flex items-center gap-3 uppercase tracking-tighter"
          >
            Enter the Hub <ChevronRight className="group-hover:translate-x-1 transition-transform" />
          </button>
          <button 
            onClick={() => window.open('https://discord.gg/projectxhub', '_blank')}
            className="px-8 py-4 border border-red-600/50 text-red-500 font-bold text-lg rounded-sm hover:bg-red-600/10 transition-all uppercase tracking-tighter"
          >
            Join Discord
          </button>
        </div>
      </div>

      {/* Floating Features Hint */}
      <div className="absolute bottom-10 animate-bounce">
        <div className="w-[1px] h-16 bg-gradient-to-b from-red-600 to-transparent"></div>
      </div>
    </section>
  );
};

const FeatureCard: React.FC<{ title: string; description: string; icon: React.ReactNode; badge?: string }> = ({ title, description, icon, badge }) => (
  <div className="relative p-8 bg-black/40 border border-red-900/30 rounded-lg hover:border-red-600 transition-all group box-glow-red-hover backdrop-blur-sm overflow-hidden">
    <div className="absolute -top-10 -right-10 w-32 h-32 bg-red-600/10 rounded-full blur-3xl group-hover:bg-red-600/20 transition-colors"></div>
    <div className="text-red-600 mb-6 scale-125">{icon}</div>
    {badge && (
      <span className="absolute top-4 right-4 text-[10px] font-tech text-black bg-red-600 px-2 py-0.5 rounded-full font-bold uppercase">
        {badge}
      </span>
    )}
    <h3 className="font-goddess text-2xl font-bold text-white mb-4 tracking-tight group-hover:text-red-500 transition-colors">{title}</h3>
    <p className="text-gray-400 font-light leading-relaxed">
      {description}
    </p>
  </div>
);

const FeaturesPage: React.FC = () => {
  return (
    <section className="py-24 px-6 bg-black">
      <div className="max-w-6xl mx-auto">
        <div className="text-center mb-16">
          <h2 className="font-goddess text-4xl md:text-5xl font-black text-white mb-4 uppercase">ENGINEERED FOR <span className="text-red-600 italic">DOMINANCE</span></h2>
          <p className="text-gray-500 font-tech uppercase tracking-widest text-xs">Unmatched Power. Zero Compromise.</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          <FeatureCard 
            icon={<ShieldAlert size={32} />}
            title="Auto Parry"
            description="Our custom-built predictive engine deflects incoming attacks with a complex algorithm that tracks hitbox velocity and latency."
          />
          <FeatureCard 
            icon={<Zap size={32} />}
            title="Infinite Parry"
            badge="Next Update"
            description="Total control. Removes the parry cooldown, removes dash cooldown, and enables auto-spam for unstoppable defensive layering."
          />
          <FeatureCard 
            icon={<Crown size={32} />}
            title="Premium Visuals"
            description="A goddess-tier UI that glows with blood-red elegance. Fully customizable, responsive, and lightweight on your resources."
          />
        </div>
      </div>
    </section>
  );
};

const ScriptSection: React.FC = () => {
  const [copiedKey, setCopiedKey] = useState(false);
  const [copiedScript, setCopiedScript] = useState(false);

  const scriptKey = "KD-6af0f0b1-bad8-4e6e-940c-0f536a39eead";
  const scriptContent = `script_key = "${scriptKey}"\nloadstring(game:HttpGet("https://api.kodamo.net/loader/fxbpontv5v9fy82ycrd9"))()`;

  const handleCopy = (text: string, setCopied: (v: boolean) => void) => {
    navigator.clipboard.writeText(text);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  return (
    <section className="min-h-screen py-32 px-6 flex flex-col items-center justify-center bg-radial-gradient">
      <div className="max-w-4xl w-full">
        <div className="mb-12 text-center">
          <div className="inline-block p-4 bg-red-600/10 border border-red-600 rounded-full mb-6">
            <Terminal className="text-red-600" size={40} />
          </div>
          <h2 className="font-goddess text-5xl font-black text-white mb-4">ACCESS THE <span className="text-red-600">SOURCE</span></h2>
          <p className="text-gray-400">Copy your unique activation key and the loader script below.</p>
        </div>

        <div className="space-y-6">
          {/* Key Box */}
          <div className="bg-neutral-900/50 border border-red-900/30 rounded-lg p-6 backdrop-blur-md relative overflow-hidden group">
            <div className="flex justify-between items-center mb-4">
              <span className="text-red-500 font-tech text-xs tracking-[0.2em] uppercase">Your Script Key</span>
              <button 
                onClick={() => handleCopy(scriptKey, setCopiedKey)}
                className="p-2 hover:bg-red-600/20 rounded-md transition-colors text-red-400 flex items-center gap-2 text-xs"
              >
                {copiedKey ? <Check size={16} /> : <Copy size={16} />}
                {copiedKey ? 'Copied!' : 'Copy Key'}
              </button>
            </div>
            <div className="font-mono text-red-500/80 break-all bg-black/40 p-4 rounded border border-red-900/20">
              {scriptKey}
            </div>
          </div>

          {/* Script Box */}
          <div className="bg-neutral-900/50 border border-red-900/30 rounded-lg p-6 backdrop-blur-md relative overflow-hidden group">
            <div className="flex justify-between items-center mb-4">
              <span className="text-red-500 font-tech text-xs tracking-[0.2em] uppercase">Loader Loadstring</span>
              <button 
                onClick={() => handleCopy(scriptContent, setCopiedScript)}
                className="p-2 hover:bg-red-600/20 rounded-md transition-colors text-red-400 flex items-center gap-2 text-xs"
              >
                {copiedScript ? <Check size={16} /> : <Copy size={16} />}
                {copiedScript ? 'Copied!' : 'Copy Script'}
              </button>
            </div>
            <div className="font-mono text-white/90 break-all bg-black/40 p-4 rounded border border-red-900/20 text-sm leading-relaxed whitespace-pre">
              {scriptContent}
            </div>
          </div>
        </div>

        <div className="mt-12 flex items-center justify-center gap-2 text-gray-500 text-xs font-tech uppercase tracking-widest animate-pulse">
          <Flame size={14} className="text-red-600" /> Auto-updates daily to bypass detections
        </div>
      </div>
    </section>
  );
};

const CommunityPage: React.FC = () => {
  return (
    <section className="min-h-screen py-32 px-6 flex flex-col items-center justify-center bg-black relative">
       {/* Background Grid */}
       <div className="absolute inset-0 opacity-10 pointer-events-none" style={{ backgroundImage: 'linear-gradient(#ff0000 1px, transparent 1px), linear-gradient(90deg, #ff0000 1px, transparent 1px)', backgroundSize: '50px 50px' }}></div>
      
      <div className="max-w-4xl w-full text-center z-10">
        <h2 className="font-goddess text-5xl md:text-6xl font-black text-white mb-8 uppercase tracking-tighter">
          THE <span className="text-red-600 glow-red underline decoration-red-600 underline-offset-8">VANGUARD</span>
        </h2>
        <p className="text-gray-400 text-lg mb-16 max-w-2xl mx-auto leading-relaxed">
          Join thousands of warriors. Support the movement, share your clips, and get early access to leaked updates.
        </p>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          {/* Discord Card */}
          <div className="bg-neutral-900/40 border-2 border-red-900/20 hover:border-red-600 rounded-2xl p-10 transition-all group cursor-pointer"
            onClick={() => window.open('https://discord.gg/projectxhub', '_blank')}>
            <div className="w-20 h-20 bg-indigo-600/20 rounded-full flex items-center justify-center mx-auto mb-6 group-hover:scale-110 transition-transform">
              <MessageSquare size={40} className="text-indigo-400" />
            </div>
            <h3 className="text-white font-goddess text-3xl font-bold mb-2">Discord Server</h3>
            <p className="text-gray-500 text-sm mb-6">Make the community popular. Support the hub.</p>
            <div className="inline-flex items-center gap-2 text-indigo-400 font-bold uppercase tracking-widest text-xs">
              Join the Hub <ExternalLink size={14} />
            </div>
          </div>

          {/* TikTok Card */}
          <div className="bg-neutral-900/40 border-2 border-red-900/20 hover:border-red-600 rounded-2xl p-10 transition-all group cursor-pointer"
            onClick={() => window.open('https://www.tiktok.com/@useprojectx', '_blank')}>
            <div className="w-20 h-20 bg-pink-600/20 rounded-full flex items-center justify-center mx-auto mb-6 group-hover:scale-110 transition-transform">
              <Video size={40} className="text-pink-400" />
            </div>
            <h3 className="text-white font-goddess text-3xl font-bold mb-2">TikTok Leaks</h3>
            <p className="text-gray-500 text-sm mb-6">Exclusive footage and upcoming feature leaks.</p>
            <div className="inline-flex items-center gap-2 text-pink-400 font-bold uppercase tracking-widest text-xs">
              Follow Us <ExternalLink size={14} />
            </div>
          </div>
        </div>
      </div>

      <footer className="mt-32 text-gray-600 font-tech text-[10px] tracking-[0.5em] uppercase">
        Project X &copy; {new Date().getFullYear()}. All Rights Reserved. Dominance Guaranteed.
      </footer>
    </section>
  );
};

// --- Main App ---

export default function App() {
  const [page, setPage] = useState<Page>('home');

  useEffect(() => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }, [page]);

  return (
    <div className="min-h-screen bg-black text-white selection:bg-red-600 selection:text-black">
      <Navbar currentPage={page} setPage={setPage} />
      
      <main className="transition-opacity duration-500">
        {page === 'home' && (
          <div className="animate-in fade-in slide-in-from-bottom-4 duration-700">
            <HeroSection onNext={() => setPage('script')} />
            <FeaturesPage />
          </div>
        )}
        
        {page === 'script' && (
          <div className="animate-in fade-in slide-in-from-bottom-4 duration-700">
            <ScriptSection />
          </div>
        )}
        
        {page === 'community' && (
          <div className="animate-in fade-in slide-in-from-bottom-4 duration-700">
            <CommunityPage />
          </div>
        )}
      </main>

      {/* Floating CTA for Mobile */}
      <div className="fixed bottom-6 right-6 md:hidden z-50">
        <button 
          onClick={() => setPage(page === 'community' ? 'home' : 'community')}
          className="w-14 h-14 bg-red-600 rounded-full flex items-center justify-center box-glow-red shadow-2xl"
        >
          {page === 'community' ? <Crown size={24} className="text-black" /> : <MessageSquare size={24} className="text-black" />}
        </button>
      </div>
    </div>
  );
}
