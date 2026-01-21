
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
  Crown,
  Eye
} from 'lucide-react';

// --- Types ---
type Page = 'home' | 'script' | 'community';

// --- Components ---

const Navbar: React.FC<{ currentPage: Page; setPage: (p: Page) => void }> = ({ currentPage, setPage }) => {
  return (
    <nav className="fixed top-0 left-0 w-full z-50 bg-black/80 backdrop-blur-md border-b border-red-900/40 px-6 py-4 flex justify-between items-center">
      <div 
        className="flex items-center gap-3 cursor-pointer group"
        onClick={() => setPage('home')}
      >
        <div className="w-10 h-10 bg-red-700 rounded-full flex items-center justify-center shadow-[0_0_20px_rgba(255,0,0,0.6)] group-hover:scale-110 transition-transform duration-300">
          <span className="font-goddess font-bold text-xl text-black">X</span>
        </div>
        <span className="font-goddess text-2xl font-black tracking-tighter text-red-600 drop-shadow-[0_0_8px_rgba(220,0,0,0.8)]">PROJECT X</span>
      </div>
      
      <div className="hidden md:flex gap-8 items-center font-tech uppercase tracking-widest text-xs">
        {['home', 'script', 'community'].map((p) => (
          <button 
            key={p}
            onClick={() => setPage(p as Page)}
            className={`${currentPage === p ? 'text-red-500 underline decoration-red-600 underline-offset-8 decoration-2' : 'text-gray-400 hover:text-white'} transition-all duration-300`}
          >
            {p === 'home' ? 'Overview' : p === 'script' ? 'Access Script' : 'The Vanguard'}
          </button>
        ))}
      </div>

      <button 
        onClick={() => setPage('script')}
        className="px-6 py-2 bg-red-600 text-black font-bold text-xs rounded-sm shadow-[0_0_15px_rgba(255,0,0,0.4)] hover:bg-red-500 hover:shadow-[0_0_25px_rgba(255,0,0,0.7)] transition-all uppercase tracking-[0.2em] font-tech"
      >
        Get Key
      </button>
    </nav>
  );
};

const HeroSection: React.FC<{ onNext: () => void }> = ({ onNext }) => {
  return (
    <section className="min-h-screen flex flex-col items-center justify-center px-4 relative overflow-hidden bg-[radial-gradient(circle_at_center,_rgba(60,0,0,0.4)_0%,_rgba(0,0,0,1)_80%)]">
      {/* Visual Decor */}
      <div className="absolute top-1/4 -left-20 w-[500px] h-[500px] bg-red-900/10 rounded-full blur-[140px] pointer-events-none animate-pulse"></div>
      <div className="absolute bottom-1/4 -right-20 w-[500px] h-[500px] bg-red-900/10 rounded-full blur-[140px] pointer-events-none animate-pulse" style={{ animationDelay: '1s' }}></div>
      
      <div className="z-10 text-center max-w-5xl">
        <div className="inline-flex items-center gap-2 px-4 py-1.5 border border-red-600/40 rounded-full text-red-500 font-tech text-[10px] tracking-[0.3em] uppercase mb-8 bg-red-950/20 backdrop-blur-sm shadow-[0_0_15px_rgba(255,0,0,0.1)]">
          <Crown size={12} className="animate-bounce" /> The Goddess Standard of Combat Excellence
        </div>
        
        <h1 className="font-goddess text-6xl md:text-[10rem] font-black mb-8 leading-[0.9] tracking-tighter">
          <span className="block text-white opacity-90">ASCEND TO</span>
          <span className="text-red-600 drop-shadow-[0_0_35px_rgba(255,0,0,0.9)] italic">PROJECT X</span>
        </h1>
        
        <p className="text-gray-400 font-light text-lg md:text-2xl mb-12 max-w-3xl mx-auto leading-relaxed">
          The ultimate utility suite for high-stakes warfare. Engineered with <span className="text-red-500 font-bold">divine precision</span>, 
          adorned with lethal power, and built for those who refuse the concept of defeat.
        </p>
        
        <div className="flex flex-col md:flex-row gap-6 justify-center items-center">
          <button 
            onClick={onNext}
            className="group relative px-10 py-5 bg-red-600 text-black font-black text-xl rounded-sm transition-all duration-500 flex items-center gap-3 uppercase tracking-tighter overflow-hidden shadow-[0_0_30px_rgba(255,0,0,0.5)] hover:shadow-[0_0_50px_rgba(255,0,0,0.8)]"
          >
            <div className="absolute inset-0 bg-white/10 translate-y-full group-hover:translate-y-0 transition-transform duration-300"></div>
            <span className="relative z-10">Enter the Hub</span> 
            <ChevronRight className="relative z-10 group-hover:translate-x-2 transition-transform duration-300" />
          </button>
          
          <button 
            onClick={() => window.open('https://discord.gg/projectxhub', '_blank')}
            className="px-10 py-5 border-2 border-red-600/40 text-red-500 font-bold text-xl rounded-sm hover:bg-red-600 hover:text-black transition-all duration-300 uppercase tracking-tighter"
          >
            Join Discord
          </button>
        </div>
      </div>

      {/* Floating Scroll Indicator */}
      <div className="absolute bottom-12 flex flex-col items-center gap-2 opacity-50">
        <span className="text-[10px] uppercase font-tech tracking-[0.4em] text-red-500">Scroll</span>
        <div className="w-[1px] h-20 bg-gradient-to-b from-red-600 to-transparent animate-pulse"></div>
      </div>
    </section>
  );
};

const FeatureCard: React.FC<{ title: string; description: string; icon: React.ReactNode; badge?: string; highlight?: boolean }> = ({ title, description, icon, badge, highlight }) => (
  <div className={`relative p-10 bg-black/60 border ${highlight ? 'border-red-600 shadow-[0_0_30px_rgba(255,0,0,0.2)]' : 'border-red-900/30'} rounded-xl hover:border-red-500 transition-all duration-500 group overflow-hidden backdrop-blur-xl`}>
    {/* Ambient Glow */}
    <div className="absolute -top-12 -right-12 w-40 h-40 bg-red-600/5 rounded-full blur-[80px] group-hover:bg-red-600/20 transition-all duration-700"></div>
    
    <div className={`mb-8 ${highlight ? 'text-red-500 drop-shadow-[0_0_10px_rgba(255,0,0,0.8)]' : 'text-red-700'} transition-transform duration-500 group-hover:scale-110`}>
      {React.cloneElement(icon as React.ReactElement, { size: 48 })}
    </div>
    
    {badge && (
      <span className="absolute top-6 right-6 text-[10px] font-tech text-black bg-red-600 px-3 py-1 rounded-full font-black uppercase tracking-widest shadow-[0_0_10px_rgba(255,0,0,0.5)]">
        {badge}
      </span>
    )}
    
    <h3 className="font-goddess text-3xl font-black text-white mb-6 tracking-tight group-hover:text-red-500 transition-colors uppercase italic">{title}</h3>
    <p className="text-gray-400 font-light text-lg leading-relaxed group-hover:text-gray-200 transition-colors">
      {description}
    </p>

    {highlight && (
      <div className="mt-8 flex items-center gap-2 text-red-500 font-tech text-[10px] tracking-[0.2em] uppercase font-bold">
        <div className="w-1.5 h-1.5 bg-red-600 rounded-full animate-ping"></div> Active Shielding Enabled
      </div>
    )}
  </div>
);

const FeaturesPage: React.FC = () => {
  return (
    <section className="py-32 px-6 bg-black relative">
      <div className="max-w-7xl mx-auto">
        <div className="text-center mb-24 space-y-4">
          <h2 className="font-goddess text-5xl md:text-7xl font-black text-white uppercase tracking-tighter">
            DIVINE <span className="text-red-600 drop-shadow-[0_0_15px_rgba(255,0,0,0.6)]">MECHANICS</span>
          </h2>
          <div className="w-24 h-1 bg-red-600 mx-auto rounded-full shadow-[0_0_10px_rgba(255,0,0,0.8)]"></div>
          <p className="text-gray-500 font-tech uppercase tracking-[0.5em] text-[10px] pt-4">Zero Latency. Zero Mercy.</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-10">
          <FeatureCard 
            highlight
            icon={<ShieldAlert />}
            title="Auto Parry"
            description="The Divine Aegis. Our predictive engine doesn't just react; it foresees. Harnessing sub-millisecond precision to deflect any strike before it even registers in your view."
          />
          <FeatureCard 
            icon={<Zap />}
            title="Infinite Parry"
            badge="Limited"
            description="Transcend human limits. Eliminates cooldown cycles entirely, enabling a constant defensive barrier that makes you mathematically untouchable."
          />
          <FeatureCard 
            icon={<Eye />}
            title="God View"
            description="The omniscient perspective. High-fidelity ESP rendering that pierces through walls, darkness, and stealth mechanics with perfect clarity."
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
    <section className="min-h-screen py-32 px-6 flex flex-col items-center justify-center bg-[radial-gradient(circle_at_top,_rgba(40,0,0,0.3)_0%,_rgba(0,0,0,1)_70%)]">
      <div className="max-w-5xl w-full">
        <div className="mb-20 text-center">
          <div className="inline-block p-6 bg-red-950/30 border-2 border-red-600 rounded-2xl mb-10 shadow-[0_0_40px_rgba(255,0,0,0.2)]">
            <Terminal className="text-red-500" size={56} />
          </div>
          <h2 className="font-goddess text-6xl font-black text-white mb-6 uppercase">CLAIM THE <span className="text-red-600">GOD-KEY</span></h2>
          <p className="text-gray-400 text-lg max-w-xl mx-auto font-light">Enter the script below into your executor to manifest the power of Project X.</p>
        </div>

        <div className="grid grid-cols-1 gap-8">
          {/* Key Box */}
          <div className="bg-neutral-900/40 border border-red-900/40 rounded-2xl p-8 backdrop-blur-2xl relative group hover:border-red-600/50 transition-all duration-500">
            <div className="flex justify-between items-center mb-6">
              <span className="text-red-500 font-tech text-xs tracking-[0.4em] uppercase font-bold">Divine Key</span>
              <button 
                onClick={() => handleCopy(scriptKey, setCopiedKey)}
                className="px-4 py-2 bg-red-600/10 hover:bg-red-600 text-red-500 hover:text-black rounded-lg transition-all duration-300 flex items-center gap-2 text-xs font-bold uppercase tracking-widest border border-red-600/20"
              >
                {copiedKey ? <Check size={16} /> : <Copy size={16} />}
                {copiedKey ? 'Manifested' : 'Copy'}
              </button>
            </div>
            <div className="font-mono text-xl md:text-2xl text-red-600/90 break-all bg-black/60 p-6 rounded-xl border border-red-900/30 shadow-inner">
              {scriptKey}
            </div>
          </div>

          {/* Script Box */}
          <div className="bg-neutral-900/40 border border-red-900/40 rounded-2xl p-8 backdrop-blur-2xl relative group hover:border-red-600/50 transition-all duration-500">
            <div className="flex justify-between items-center mb-6">
              <span className="text-red-500 font-tech text-xs tracking-[0.4em] uppercase font-bold">Loader Stream</span>
              <button 
                onClick={() => handleCopy(scriptContent, setCopiedScript)}
                className="px-4 py-2 bg-red-600/10 hover:bg-red-600 text-red-500 hover:text-black rounded-lg transition-all duration-300 flex items-center gap-2 text-xs font-bold uppercase tracking-widest border border-red-600/20"
              >
                {copiedScript ? <Check size={16} /> : <Copy size={16} />}
                {copiedScript ? 'Secured' : 'Copy Code'}
              </button>
            </div>
            <div className="font-mono text-white/80 break-all bg-black/60 p-6 rounded-xl border border-red-900/30 text-sm md:text-base leading-relaxed whitespace-pre shadow-inner h-32 overflow-y-auto custom-scrollbar">
              {scriptContent}
            </div>
          </div>
        </div>

        <div className="mt-20 flex flex-col items-center gap-4 text-gray-500 text-[10px] font-tech uppercase tracking-[0.6em]">
          <div className="flex items-center gap-4">
            <div className="w-12 h-[1px] bg-red-900"></div>
            <Flame size={16} className="text-red-600 animate-pulse" />
            <div className="w-12 h-[1px] bg-red-900"></div>
          </div>
          Undetected & Refined Daily
        </div>
      </div>
    </section>
  );
};

const CommunityPage: React.FC = () => {
  return (
    <section className="min-h-screen py-32 px-6 flex flex-col items-center justify-center bg-black relative overflow-hidden">
       {/* Background Grid Overlay */}
       <div className="absolute inset-0 opacity-[0.03] pointer-events-none" style={{ backgroundImage: 'linear-gradient(#ff0000 1px, transparent 1px), linear-gradient(90deg, #ff0000 1px, transparent 1px)', backgroundSize: '60px 60px' }}></div>
      
      <div className="max-w-6xl w-full text-center z-10">
        <h2 className="font-goddess text-6xl md:text-8xl font-black text-white mb-10 uppercase tracking-tighter">
          JOIN THE <span className="text-red-600 drop-shadow-[0_0_25px_rgba(255,0,0,0.7)] italic">LEGION</span>
        </h2>
        <p className="text-gray-400 text-xl mb-24 max-w-2xl mx-auto font-light leading-relaxed">
          The vanguard of the new era. Connect with the elite, share your triumphs, and influence the future of Project X.
        </p>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-12">
          {/* Discord Card */}
          <div className="bg-neutral-900/40 border-2 border-red-900/20 hover:border-red-600 rounded-3xl p-12 transition-all duration-500 group cursor-pointer shadow-[0_0_50px_rgba(0,0,0,0.5)] hover:shadow-[0_0_40px_rgba(255,0,0,0.2)]"
            onClick={() => window.open('https://discord.gg/projectxhub', '_blank')}>
            <div className="w-24 h-24 bg-indigo-600/10 border border-indigo-600/30 rounded-2xl flex items-center justify-center mx-auto mb-10 group-hover:scale-110 transition-transform duration-500 group-hover:shadow-[0_0_30px_rgba(79,70,229,0.3)]">
              <MessageSquare size={48} className="text-indigo-400" />
            </div>
            <h3 className="text-white font-goddess text-4xl font-black mb-4 uppercase italic">Project Hub</h3>
            <p className="text-gray-500 text-sm mb-10 tracking-wide leading-relaxed">The sanctum for high-level discussion, support, and exclusive beta drops.</p>
            <div className="inline-flex items-center gap-3 text-indigo-400 font-black uppercase tracking-[0.3em] text-xs">
              Enter Sanctuary <ExternalLink size={16} />
            </div>
          </div>

          {/* TikTok Card */}
          <div className="bg-neutral-900/40 border-2 border-red-900/20 hover:border-red-600 rounded-3xl p-12 transition-all duration-500 group cursor-pointer shadow-[0_0_50px_rgba(0,0,0,0.5)] hover:shadow-[0_0_40px_rgba(255,0,0,0.2)]"
            onClick={() => window.open('https://www.tiktok.com/@useprojectx', '_blank')}>
            <div className="w-24 h-24 bg-pink-600/10 border border-pink-600/30 rounded-2xl flex items-center justify-center mx-auto mb-10 group-hover:scale-110 transition-transform duration-500 group-hover:shadow-[0_0_30px_rgba(219,39,119,0.3)]">
              <Video size={48} className="text-pink-400" />
            </div>
            <h3 className="text-white font-goddess text-4xl font-black mb-4 uppercase italic">TikTok Archives</h3>
            <p className="text-gray-500 text-sm mb-10 tracking-wide leading-relaxed">Visual proof of dominance. Raw clips of the Goddess in action.</p>
            <div className="inline-flex items-center gap-3 text-pink-400 font-black uppercase tracking-[0.3em] text-xs">
              Witness Glory <ExternalLink size={16} />
            </div>
          </div>
        </div>
      </div>

      <footer className="mt-40 text-gray-700 font-tech text-[10px] tracking-[0.8em] uppercase border-t border-red-900/10 pt-10 w-full text-center">
        &copy; {new Date().getFullYear()} Project X. Eternal Supremacy.
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
      
      <main className="transition-all duration-700 ease-in-out">
        {page === 'home' && (
          <div className="animate-in fade-in zoom-in-95 duration-1000">
            <HeroSection onNext={() => setPage('script')} />
            <FeaturesPage />
          </div>
        )}
        
        {page === 'script' && (
          <div className="animate-in fade-in slide-in-from-bottom-8 duration-700">
            <ScriptSection />
          </div>
        )}
        
        {page === 'community' && (
          <div className="animate-in fade-in slide-in-from-bottom-8 duration-700">
            <CommunityPage />
          </div>
        )}
      </main>

      {/* Floating CTA for Mobile */}
      <div className="fixed bottom-8 right-8 md:hidden z-50">
        <button 
          onClick={() => setPage(page === 'community' ? 'home' : 'community')}
          className="w-16 h-16 bg-red-700 rounded-full flex items-center justify-center shadow-[0_0_30px_rgba(255,0,0,0.6)] active:scale-90 transition-transform"
        >
          {page === 'community' ? <Crown size={32} className="text-black" /> : <MessageSquare size={32} className="text-black" />}
        </button>
      </div>
    </div>
  );
}
