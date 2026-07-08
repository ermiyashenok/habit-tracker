<!-- Hall of Fame -->
<!DOCTYPE html>

<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Hall of Fame - Achievements</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@700;800&amp;family=Be+Vietnam+Pro:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .filled-icon {
            font-variation-settings: 'FILL' 1;
        }
        /* Chunky Button / Card Physics */
        .chunky-card {
            box-shadow: 0 6px 0 0 var(--tw-shadow-color);
            transition: all 0.1s ease;
        }
        .chunky-card:active {
            transform: translateY(4px);
            box-shadow: 0 2px 0 0 var(--tw-shadow-color);
        }
        .achievement-badge {
            transition: transform 0.2s cubic-bezier(0.34, 1.56, 0.64, 1);
        }
        .achievement-badge:active {
            transform: scale(0.9);
        }
        /* Hide scrollbar but keep functionality */
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
    </style>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "outline-variant": "#becbb1",
                        "primary": "#2b6c00",
                        "on-tertiary-container": "#004a6b",
                        "surface-bg": "#F7F7F7",
                        "secondary-fixed-dim": "#ffb872",
                        "inverse-on-surface": "#f2f0f0",
                        "on-secondary-fixed-variant": "#6a3b00",
                        "on-surface": "#1b1c1c",
                        "error-red": "#FF4B4B",
                        "on-tertiary-fixed-variant": "#004c6e",
                        "on-primary": "#ffffff",
                        "secondary-container": "#fd9500",
                        "surface": "#fbf9f9",
                        "surface-container-low": "#f5f3f3",
                        "on-error": "#ffffff",
                        "surface-bright": "#fbf9f9",
                        "surface-container-high": "#e9e8e7",
                        "error": "#ba1a1a",
                        "on-tertiary-fixed": "#001e2e",
                        "secondary": "#8c5000",
                        "primary-fixed-dim": "#6be026",
                        "tertiary-fixed-dim": "#88ceff",
                        "outline": "#6f7b64",
                        "tertiary-container": "#4abdff",
                        "celebratory-purple": "#CE82FF",
                        "border-depth": "rgba(0, 0, 0, 0.2)",
                        "inverse-primary": "#6be026",
                        "on-primary-container": "#1e5000",
                        "tertiary": "#006590",
                        "surface-container": "#efeded",
                        "on-primary-fixed-variant": "#1f5100",
                        "surface-container-lowest": "#ffffff",
                        "background": "#fbf9f9",
                        "on-primary-fixed": "#082100",
                        "surface-tint": "#2b6c00",
                        "secondary-fixed": "#ffdcbf",
                        "surface-card": "#FFFFFF",
                        "error-container": "#ffdad6",
                        "primary-fixed": "#87fe45",
                        "on-error-container": "#93000a",
                        "on-secondary-fixed": "#2d1600",
                        "surface-dim": "#dbdad9",
                        "on-secondary": "#ffffff",
                        "surface-variant": "#e3e2e2",
                        "on-surface-variant": "#3f4a36",
                        "on-tertiary": "#ffffff",
                        "primary-container": "#58cc02",
                        "surface-container-highest": "#e3e2e2",
                        "on-secondary-container": "#633700",
                        "tertiary-fixed": "#c8e6ff",
                        "inverse-surface": "#303031",
                        "on-background": "#1b1c1c"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "stack-sm": "8px",
                        "gutter": "12px",
                        "margin-mobile": "16px",
                        "margin-desktop": "32px",
                        "stack-md": "16px",
                        "base-unit": "4px",
                        "stack-lg": "24px"
                    },
                    "fontFamily": {
                        "headline-lg-mobile": ["Plus Jakarta Sans"],
                        "label-bold": ["Be Vietnam Pro"],
                        "display-hero": ["Plus Jakarta Sans"],
                        "body-md": ["Be Vietnam Pro"],
                        "body-lg": ["Be Vietnam Pro"],
                        "label-sm": ["Be Vietnam Pro"],
                        "headline-lg": ["Plus Jakarta Sans"],
                        "headline-md": ["Plus Jakarta Sans"]
                    },
                    "fontSize": {
                        "headline-lg-mobile": ["24px", {"lineHeight": "30px", "fontWeight": "800"}],
                        "label-bold": ["14px", {"lineHeight": "20px", "letterSpacing": "0.05em", "fontWeight": "700"}],
                        "display-hero": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "800"}],
                        "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "500"}],
                        "body-lg": ["18px", {"lineHeight": "26px", "fontWeight": "500"}],
                        "label-sm": ["13px", {"lineHeight": "18px", "fontWeight": "400"}],
                        "headline-lg": ["28px", {"lineHeight": "34px", "fontWeight": "800"}],
                        "headline-md": ["20px", {"lineHeight": "26px", "fontWeight": "700"}]
                    }
                },
            },
        }
    </script>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-surface-bg font-body-md text-on-surface overflow-x-hidden no-scrollbar">
<!-- Top Navigation Anchor -->
<header class="fixed top-0 w-full z-50 bg-surface border-b-4 border-surface-container-high flex justify-between items-center px-margin-mobile h-16">
<div class="flex items-center gap-2">
<div class="w-10 h-10 rounded-full border-2 border-primary overflow-hidden shadow-[0_2px_0_0_#1e5000]">
<img class="w-full h-full object-cover" data-alt="A stylized portrait of a smiling user wearing a shiny gold celebratory crown, digital illustration style like a premium profile avatar, bright high-energy colors, clear focus on a white background." src="https://lh3.googleusercontent.com/aida-public/AB6AXuDAukBFgoIVJgEzCh1s49MT7PfjjBFV1w0xTeWIsqp6-tJsinILtMs5SHLu4nVTCMc4Nj7EGzSoLEzvdrrF-4pKr-1tl9a3DAAwk_3Wd85kXOgpiFQvwdtQhvXWY0PmxPyVbUCBD1L0jF4PFhNvK5K0eW1mGcJqp36hdxUmz1QQRBTXpBx-kEBp4clG2gskbTYKItlKkE_FyeKqydaBuEYTakEjqbaEjnHJerVXvD8Pnty_ifG6Fzpyitlm5IcJbezCSvi94mV56nAJ"/>
</div>
</div>
<h1 class="font-headline-lg-mobile text-headline-lg-mobile text-primary tracking-tighter uppercase">QUEST LOG</h1>
<div class="flex items-center gap-2 text-primary active:translate-y-1 transition-transform cursor-pointer">
<span class="material-symbols-outlined filled-icon" style="font-variation-settings: 'FILL' 1;">local_fire_department</span>
<span class="font-label-bold text-label-bold">12</span>
</div>
</header>
<main class="pt-24 pb-32 px-margin-mobile min-h-screen max-w-2xl mx-auto">
<!-- Hall of Fame Header -->
<div class="mb-stack-lg text-center">
<h2 class="font-display-hero text-headline-lg text-on-surface mb-2">Hall of Fame</h2>
<div class="bg-primary-container text-on-primary-container inline-block px-4 py-1 rounded-full border-b-4 border-primary font-label-bold text-label-sm">
                14 / 24 UNLOCKED
            </div>
</div>
<!-- Achievement Categories Grid -->
<div class="grid grid-cols-3 gap-gutter sm:grid-cols-4">
<!-- Earned Badge 1 -->
<div class="achievement-badge flex flex-col items-center gap-2 cursor-pointer" onclick="showDetail('7 Day Streak!', 'Logged in for 7 consecutive days. You\'re a firestarter!', 'local_fire_department', '#fd9500')">
<div class="w-20 h-20 rounded-full bg-secondary-container border-4 border-secondary flex items-center justify-center shadow-[0_6px_0_0_#8c5000] relative overflow-hidden group">
<div class="absolute inset-0 bg-white opacity-0 group-hover:opacity-20 transition-opacity"></div>
<span class="material-symbols-outlined text-white text-4xl filled-icon" style="font-variation-settings: 'FILL' 1;">local_fire_department</span>
</div>
<span class="font-label-bold text-label-sm text-center">Firestarter</span>
</div>
<!-- Earned Badge 2 -->
<div class="achievement-badge flex flex-col items-center gap-2 cursor-pointer" onclick="showDetail('Night Owl', 'Completed a quest after midnight. Sleep is for the weak!', 'dark_mode', '#CE82FF')">
<div class="w-20 h-20 rounded-full bg-celebratory-purple border-4 border-[#9d4edd] flex items-center justify-center shadow-[0_6px_0_0_#7b2cbf] relative overflow-hidden">
<span class="material-symbols-outlined text-white text-4xl filled-icon" style="font-variation-settings: 'FILL' 1;">dark_mode</span>
</div>
<span class="font-label-bold text-label-sm text-center">Night Owl</span>
</div>
<!-- Earned Badge 3 -->
<div class="achievement-badge flex flex-col items-center gap-2 cursor-pointer" onclick="showDetail('Social Butterfly', 'Added your first 5 friends. The more the merrier!', 'group', '#4abdff')">
<div class="w-20 h-20 rounded-full bg-tertiary-container border-4 border-tertiary flex items-center justify-center shadow-[0_6px_0_0_#004c6e] relative overflow-hidden">
<span class="material-symbols-outlined text-white text-4xl filled-icon" style="font-variation-settings: 'FILL' 1;">group</span>
</div>
<span class="font-label-bold text-label-sm text-center">Socialite</span>
</div>
<!-- Locked Badge 1 -->
<div class="achievement-badge flex flex-col items-center gap-2 cursor-pointer opacity-80" onclick="showDetail('Iron Will', 'Maintain a 30 day streak to unlock this legendary medal.', 'lock', '#dbdad9')">
<div class="w-20 h-20 rounded-full bg-surface-dim border-4 border-outline flex items-center justify-center shadow-[0_6px_0_0_#6f7b64] grayscale relative">
<span class="material-symbols-outlined text-outline text-4xl">fitness_center</span>
<div class="absolute -bottom-1 -right-1 bg-on-surface w-8 h-8 rounded-full border-2 border-surface flex items-center justify-center">
<span class="material-symbols-outlined text-white text-lg">lock</span>
</div>
</div>
<span class="font-label-bold text-label-sm text-center text-outline">Locked</span>
</div>
<!-- Earned Badge 4 -->
<div class="achievement-badge flex flex-col items-center gap-2 cursor-pointer" onclick="showDetail('Early Bird', 'First quest completed before 7 AM. The worm is yours.', 'wb_sunny', '#58cc02')">
<div class="w-20 h-20 rounded-full bg-primary-container border-4 border-primary flex items-center justify-center shadow-[0_6px_0_0_#1e5000] relative overflow-hidden">
<span class="material-symbols-outlined text-white text-4xl filled-icon" style="font-variation-settings: 'FILL' 1;">wb_sunny</span>
</div>
<span class="font-label-bold text-label-sm text-center">Early Bird</span>
</div>
<!-- Locked Badge 2 -->
<div class="achievement-badge flex flex-col items-center gap-2 cursor-pointer opacity-80" onclick="showDetail('Master Planner', 'Schedule 50 tasks in one week. Order from chaos.', 'lock', '#dbdad9')">
<div class="w-20 h-20 rounded-full bg-surface-dim border-4 border-outline flex items-center justify-center shadow-[0_6px_0_0_#6f7b64] grayscale relative">
<span class="material-symbols-outlined text-outline text-4xl">calendar_month</span>
<div class="absolute -bottom-1 -right-1 bg-on-surface w-8 h-8 rounded-full border-2 border-surface flex items-center justify-center">
<span class="material-symbols-outlined text-white text-lg">lock</span>
</div>
</div>
<span class="font-label-bold text-label-sm text-center text-outline">Locked</span>
</div>
<!-- Earned Badge 5 -->
<div class="achievement-badge flex flex-col items-center gap-2 cursor-pointer" onclick="showDetail('Jackpot', 'Earn 1000 XP in a single day. You\'re on a roll!', 'star', '#fd9500')">
<div class="w-20 h-20 rounded-full bg-secondary-container border-4 border-secondary flex items-center justify-center shadow-[0_6px_0_0_#8c5000] relative overflow-hidden">
<span class="material-symbols-outlined text-white text-4xl filled-icon" style="font-variation-settings: 'FILL' 1;">star</span>
</div>
<span class="font-label-bold text-label-sm text-center">Jackpot</span>
</div>
<!-- Locked Badge 3 -->
<div class="achievement-badge flex flex-col items-center gap-2 cursor-pointer opacity-80" onclick="showDetail('Champion', 'Reach the Diamond League in weekly stats.', 'lock', '#dbdad9')">
<div class="w-20 h-20 rounded-full bg-surface-dim border-4 border-outline flex items-center justify-center shadow-[0_6px_0_0_#6f7b64] grayscale relative">
<span class="material-symbols-outlined text-outline text-4xl">trophy</span>
<div class="absolute -bottom-1 -right-1 bg-on-surface w-8 h-8 rounded-full border-2 border-surface flex items-center justify-center">
<span class="material-symbols-outlined text-white text-lg">lock</span>
</div>
</div>
<span class="font-label-bold text-label-sm text-center text-outline">Locked</span>
</div>
<!-- More placeholders to fill the grid -->
<div class="achievement-badge flex flex-col items-center gap-2 cursor-pointer opacity-80">
<div class="w-20 h-20 rounded-full bg-surface-dim border-4 border-outline flex items-center justify-center shadow-[0_6px_0_0_#6f7b64] grayscale relative">
<span class="material-symbols-outlined text-outline text-4xl">rocket_launch</span>
<div class="absolute -bottom-1 -right-1 bg-on-surface w-8 h-8 rounded-full border-2 border-surface flex items-center justify-center">
<span class="material-symbols-outlined text-white text-lg">lock</span>
</div>
</div>
<span class="font-label-bold text-label-sm text-center text-outline">Locked</span>
</div>
<div class="achievement-badge flex flex-col items-center gap-2 cursor-pointer opacity-80">
<div class="w-20 h-20 rounded-full bg-surface-dim border-4 border-outline flex items-center justify-center shadow-[0_6px_0_0_#6f7b64] grayscale relative">
<span class="material-symbols-outlined text-outline text-4xl">history_edu</span>
<div class="absolute -bottom-1 -right-1 bg-on-surface w-8 h-8 rounded-full border-2 border-surface flex items-center justify-center">
<span class="material-symbols-outlined text-white text-lg">lock</span>
</div>
</div>
<span class="font-label-bold text-label-sm text-center text-outline">Locked</span>
</div>
<div class="achievement-badge flex flex-col items-center gap-2 cursor-pointer opacity-80">
<div class="w-20 h-20 rounded-full bg-surface-dim border-4 border-outline flex items-center justify-center shadow-[0_6px_0_0_#6f7b64] grayscale relative">
<span class="material-symbols-outlined text-outline text-4xl">bolt</span>
<div class="absolute -bottom-1 -right-1 bg-on-surface w-8 h-8 rounded-full border-2 border-surface flex items-center justify-center">
<span class="material-symbols-outlined text-white text-lg">lock</span>
</div>
</div>
<span class="font-label-bold text-label-sm text-center text-outline">Locked</span>
</div>
<div class="achievement-badge flex flex-col items-center gap-2 cursor-pointer opacity-80">
<div class="w-20 h-20 rounded-full bg-surface-dim border-4 border-outline flex items-center justify-center shadow-[0_6px_0_0_#6f7b64] grayscale relative">
<span class="material-symbols-outlined text-outline text-4xl">forest</span>
<div class="absolute -bottom-1 -right-1 bg-on-surface w-8 h-8 rounded-full border-2 border-surface flex items-center justify-center">
<span class="material-symbols-outlined text-white text-lg">lock</span>
</div>
</div>
<span class="font-label-bold text-label-sm text-center text-outline">Locked</span>
</div>
</div>
<!-- Featured Achievement Card -->
<div class="mt-stack-lg p-6 bg-surface-card border-4 border-surface-container-highest rounded-xl shadow-[0_8px_0_0_#efeded] flex items-center gap-4">
<div class="w-16 h-16 shrink-0 rounded-xl bg-celebratory-purple flex items-center justify-center">
<span class="material-symbols-outlined text-white text-3xl filled-icon" style="font-variation-settings: 'FILL' 1;">military_tech</span>
</div>
<div>
<h3 class="font-headline-md text-on-surface">Next Milestone</h3>
<p class="text-body-md text-on-surface-variant leading-tight">Complete 5 more tasks to unlock "The Finisher"</p>
<div class="mt-2 w-full h-4 bg-surface-container-low rounded-full overflow-hidden border-2 border-surface-container-high">
<div class="bg-primary-container h-full border-r-4 border-primary" style="width: 60%"></div>
</div>
</div>
</div>
</main>
<!-- Modal Backdrop -->
<div class="fixed inset-0 bg-black/40 z-[60] hidden flex items-center justify-center p-margin-mobile backdrop-blur-sm transition-opacity opacity-0" id="modalBackdrop">
<!-- Achievement Popover -->
<div class="bg-surface border-4 border-on-surface rounded-2xl w-full max-w-sm overflow-hidden transform scale-95 transition-transform duration-200 shadow-[0_12px_0_0_rgba(0,0,0,0.2)]" id="achievementCard">
<div class="h-32 flex items-center justify-center relative" id="modalHeader">
<!-- Background Pattern -->
<div class="absolute inset-0 opacity-20" style="background-image: radial-gradient(circle at 2px 2px, white 1px, transparent 0); background-size: 16px 16px;"></div>
<div class="w-20 h-20 rounded-full border-4 border-white flex items-center justify-center relative z-10 shadow-lg" id="modalIconContainer">
<span class="material-symbols-outlined text-white text-5xl" id="modalIcon">star</span>
</div>
</div>
<div class="p-6 text-center">
<h2 class="font-headline-lg text-on-surface mb-2" id="modalTitle">Achievement Title</h2>
<p class="text-body-lg text-on-surface-variant mb-6" id="modalDesc">This is where the achievement description goes.</p>
<button class="w-full py-4 bg-primary-container text-on-primary-container font-label-bold rounded-xl border-b-4 border-primary active:translate-y-1 active:shadow-none shadow-[0_4px_0_0_#1e5000] uppercase tracking-wider" onclick="hideDetail()">
                    Awesome!
                </button>
</div>
</div>
</div>
<!-- Bottom Navigation Anchor -->
<nav class="fixed bottom-0 w-full z-50 bg-surface rounded-t-xl border-t-4 border-surface-container-high flex justify-around items-end pb-4 px-2">
<a class="flex flex-col items-center justify-center text-outline pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined">bolt</span>
<span class="font-label-bold text-label-bold">Today</span>
</a>
<a class="flex flex-col items-center justify-center text-outline pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined">calendar_today</span>
<span class="font-label-bold text-label-bold">Planner</span>
</a>
<a class="flex flex-col items-center justify-center text-primary border-t-4 border-primary pt-2 active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined filled-icon" style="font-variation-settings: 'FILL' 1;">leaderboard</span>
<span class="font-label-bold text-label-bold">Stats</span>
</a>
<a class="flex flex-col items-center justify-center text-outline pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined">group</span>
<span class="font-label-bold text-label-bold">Friends</span>
</a>
</nav>
<script>
        function showDetail(title, desc, icon, color) {
            const backdrop = document.getElementById('modalBackdrop');
            const card = document.getElementById('achievementCard');
            const modalHeader = document.getElementById('modalHeader');
            const modalIconContainer = document.getElementById('modalIconContainer');
            const modalIcon = document.getElementById('modalIcon');
            const modalTitle = document.getElementById('modalTitle');
            const modalDesc = document.getElementById('modalDesc');

            modalTitle.innerText = title;
            modalDesc.innerText = desc;
            modalIcon.innerText = icon;
            modalHeader.style.backgroundColor = color;
            modalIconContainer.style.backgroundColor = color;

            if (icon === 'lock') {
                modalIconContainer.style.backgroundColor = '#6f7b64';
                modalHeader.style.backgroundColor = '#dbdad9';
                modalIcon.innerText = 'lock';
            }

            backdrop.classList.remove('hidden');
            setTimeout(() => {
                backdrop.classList.add('opacity-100');
                card.classList.add('scale-100');
            }, 10);
        }

        function hideDetail() {
            const backdrop = document.getElementById('modalBackdrop');
            const card = document.getElementById('achievementCard');
            
            backdrop.classList.remove('opacity-100');
            card.classList.remove('scale-100');
            
            setTimeout(() => {
                backdrop.classList.add('hidden');
            }, 200);
        }

        // Close modal on backdrop click
        document.getElementById('modalBackdrop').addEventListener('click', (e) => {
            if (e.target === document.getElementById('modalBackdrop')) {
                hideDetail();
            }
        });
    </script>
</body></html>

<!-- Quest Details -->
<!DOCTYPE html>

<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Quest Log - Activity Detail</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@700;800&amp;family=Be+Vietnam+Pro:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "outline-variant": "#becbb1",
                        "primary": "#2b6c00",
                        "on-tertiary-container": "#004a6b",
                        "surface-bg": "#F7F7F7",
                        "secondary-fixed-dim": "#ffb872",
                        "inverse-on-surface": "#f2f0f0",
                        "on-secondary-fixed-variant": "#6a3b00",
                        "on-surface": "#1b1c1c",
                        "error-red": "#FF4B4B",
                        "on-tertiary-fixed-variant": "#004c6e",
                        "on-primary": "#ffffff",
                        "secondary-container": "#fd9500",
                        "surface": "#fbf9f9",
                        "surface-container-low": "#f5f3f3",
                        "on-error": "#ffffff",
                        "surface-bright": "#fbf9f9",
                        "surface-container-high": "#e9e8e7",
                        "error": "#ba1a1a",
                        "on-tertiary-fixed": "#001e2e",
                        "secondary": "#8c5000",
                        "primary-fixed-dim": "#6be026",
                        "tertiary-fixed-dim": "#88ceff",
                        "outline": "#6f7b64",
                        "tertiary-container": "#4abdff",
                        "celebratory-purple": "#CE82FF",
                        "border-depth": "rgba(0, 0, 0, 0.2)",
                        "inverse-primary": "#6be026",
                        "on-primary-container": "#1e5000",
                        "tertiary": "#006590",
                        "surface-container": "#efeded",
                        "on-primary-fixed-variant": "#1f5100",
                        "surface-container-lowest": "#ffffff",
                        "background": "#fbf9f9",
                        "on-primary-fixed": "#082100",
                        "surface-tint": "#2b6c00",
                        "secondary-fixed": "#ffdcbf",
                        "surface-card": "#FFFFFF",
                        "error-container": "#ffdad6",
                        "primary-fixed": "#87fe45",
                        "on-error-container": "#93000a",
                        "on-secondary-fixed": "#2d1600",
                        "surface-dim": "#dbdad9",
                        "on-secondary": "#ffffff",
                        "surface-variant": "#e3e2e2",
                        "on-surface-variant": "#3f4a36",
                        "on-tertiary": "#ffffff",
                        "primary-container": "#58cc02",
                        "surface-container-highest": "#e3e2e2",
                        "on-secondary-container": "#633700",
                        "tertiary-fixed": "#c8e6ff",
                        "inverse-surface": "#303031",
                        "on-background": "#1b1c1c"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "stack-sm": "8px",
                        "gutter": "12px",
                        "margin-mobile": "16px",
                        "margin-desktop": "32px",
                        "stack-md": "16px",
                        "base-unit": "4px",
                        "stack-lg": "24px"
                    },
                    "fontFamily": {
                        "headline-lg-mobile": ["Plus Jakarta Sans"],
                        "label-bold": ["Be Vietnam Pro"],
                        "display-hero": ["Plus Jakarta Sans"],
                        "body-md": ["Be Vietnam Pro"],
                        "body-lg": ["Be Vietnam Pro"],
                        "label-sm": ["Be Vietnam Pro"],
                        "headline-lg": ["Plus Jakarta Sans"],
                        "headline-md": ["Plus Jakarta Sans"]
                    },
                    "fontSize": {
                        "headline-lg-mobile": ["24px", {"lineHeight": "30px", "fontWeight": "800"}],
                        "label-bold": ["14px", {"lineHeight": "20px", "letterSpacing": "0.05em", "fontWeight": "700"}],
                        "display-hero": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "800"}],
                        "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "500"}],
                        "body-lg": ["18px", {"lineHeight": "26px", "fontWeight": "500"}],
                        "label-sm": ["13px", {"lineHeight": "18px", "fontWeight": "400"}],
                        "headline-lg": ["28px", {"lineHeight": "34px", "fontWeight": "800"}],
                        "headline-md": ["20px", {"lineHeight": "26px", "fontWeight": "700"}]
                    }
                },
            },
        }
    </script>
<style>
        .chunky-shadow-primary {
            box-shadow: 0 6px 0 0 #1f5100;
        }
        .chunky-shadow-secondary {
            box-shadow: 0 6px 0 0 #633700;
        }
        .chunky-shadow-error {
            box-shadow: 0 6px 0 0 #93000a;
        }
        .chunky-shadow-surface {
            box-shadow: 0 6px 0 0 #dbdad9;
        }
        .chunky-button-press:active {
            transform: translateY(4px);
            box-shadow: none !important;
        }
        .heatmap-cell {
            width: 100%;
            aspect-ratio: 1/1;
            border-radius: 8px;
            border: 2px solid #e3e2e2;
        }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-surface-bg text-on-surface font-body-md min-h-screen pb-24">
<!-- TopAppBar -->
<header class="fixed top-0 w-full z-50 bg-surface border-b-4 border-surface-container-high flex justify-between items-center px-margin-mobile h-16">
<button class="flex items-center justify-center text-primary active:translate-y-1 transition-transform">
<span class="material-symbols-outlined">arrow_back</span>
</button>
<h1 class="font-headline-lg-mobile text-headline-lg-mobile text-primary tracking-tighter uppercase">QUEST LOG</h1>
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-secondary-container" style="font-variation-settings: 'FILL' 1;">local_fire_department</span>
<span class="font-label-bold text-label-bold text-secondary">24</span>
</div>
</header>
<main class="pt-20 px-margin-mobile max-w-2xl mx-auto space-y-stack-lg">
<!-- Activity Title & Summary -->
<section class="text-center space-y-2 py-4">
<h2 class="font-headline-lg text-headline-lg text-on-surface">Daily Coding Challenge</h2>
<p class="text-on-surface-variant font-body-md">Solve at least one LeetCode medium</p>
</section>
<!-- Current Streak Hero Card -->
<section class="relative bg-surface border-2 border-surface-container-highest rounded-xl p-8 text-center chunky-shadow-surface">
<div class="inline-flex flex-col items-center">
<div class="relative mb-2">
<span class="material-symbols-outlined text-secondary-container" style="font-size: 80px; font-variation-settings: 'FILL' 1;">local_fire_department</span>
<div class="absolute -top-2 -right-2 bg-celebratory-purple text-white px-2 py-1 rounded-full text-xs font-bold animate-bounce">NEW RECORD!</div>
</div>
<div class="font-display-hero text-display-hero text-on-surface">24</div>
<div class="font-label-bold text-label-bold text-secondary uppercase tracking-widest">Day Streak</div>
</div>
<!-- Encouragement Badge -->
<div class="mt-6 bg-primary-container/10 border-2 border-primary-container rounded-xl p-4 flex items-center gap-4">
<span class="material-symbols-outlined text-primary" style="font-size: 32px;">verified</span>
<p class="text-left font-label-bold text-label-bold text-on-primary-container leading-tight">
                    You're in the top 5% of all questers this month! Keep it up.
                </p>
</div>
</section>
<!-- Stats Bento Grid -->
<section class="grid grid-cols-2 gap-stack-md">
<!-- Longest Streak -->
<div class="bg-surface-card border-2 border-surface-container-highest rounded-xl p-stack-md chunky-shadow-surface">
<div class="flex items-center gap-2 text-on-surface-variant mb-2">
<span class="material-symbols-outlined text-secondary">workspace_premium</span>
<span class="font-label-bold text-label-sm uppercase">Longest</span>
</div>
<div class="font-headline-lg text-headline-lg">42 <span class="text-body-md font-body-md text-on-surface-variant">days</span></div>
</div>
<!-- Total Completions -->
<div class="bg-surface-card border-2 border-surface-container-highest rounded-xl p-stack-md chunky-shadow-surface">
<div class="flex items-center gap-2 text-on-surface-variant mb-2">
<span class="material-symbols-outlined text-tertiary">check_circle</span>
<span class="font-label-bold text-label-sm uppercase">Total</span>
</div>
<div class="font-headline-lg text-headline-lg">158 <span class="text-body-md font-body-md text-on-surface-variant">times</span></div>
</div>
</section>
<!-- Calendar Heatmap -->
<section class="bg-surface-card border-2 border-surface-container-highest rounded-xl p-stack-md chunky-shadow-surface space-y-stack-md">
<div class="flex justify-between items-center">
<h3 class="font-headline-md text-headline-md">Consistency</h3>
<span class="text-on-surface-variant font-label-bold text-label-sm">LAST 30 DAYS</span>
</div>
<div class="grid grid-cols-7 gap-2" id="heatmap-grid">
<!-- Heatmap cells generated by JS -->
</div>
<div class="flex justify-between items-center pt-2 border-t border-surface-variant text-label-sm font-label-bold text-on-surface-variant">
<span>Less</span>
<div class="flex gap-1">
<div class="w-3 h-3 rounded-sm bg-surface-container-highest"></div>
<div class="w-3 h-3 rounded-sm bg-primary/20"></div>
<div class="w-3 h-3 rounded-sm bg-primary/40"></div>
<div class="w-3 h-3 rounded-sm bg-primary/70"></div>
<div class="w-3 h-3 rounded-sm bg-primary"></div>
</div>
<span>More</span>
</div>
</section>
<!-- Action Buttons -->
<section class="space-y-stack-md pt-4">
<button class="w-full h-14 bg-primary text-on-primary font-headline-md text-headline-md rounded-xl chunky-shadow-primary chunky-button-press transition-all flex items-center justify-center gap-2">
<span class="material-symbols-outlined">edit</span>
                Edit Quest
            </button>
<div class="grid grid-cols-2 gap-stack-md">
<button class="h-14 bg-surface text-secondary font-label-bold text-label-bold border-2 border-secondary/20 rounded-xl chunky-shadow-secondary chunky-button-press transition-all flex items-center justify-center gap-2">
<span class="material-symbols-outlined">pause_circle</span>
                    Pause
                </button>
<button class="h-14 bg-surface text-error font-label-bold text-label-bold border-2 border-error/20 rounded-xl chunky-shadow-error chunky-button-press transition-all flex items-center justify-center gap-2">
<span class="material-symbols-outlined">delete</span>
                    Archive
                </button>
</div>
</section>
</main>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 w-full z-50 bg-surface rounded-t-xl border-t-4 border-surface-container-high flex justify-around items-end pb-4 px-2">
<a class="flex flex-col items-center justify-center text-primary border-t-4 border-primary pt-2 active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined">bolt</span>
<span class="font-label-bold text-label-bold">Today</span>
</a>
<a class="flex flex-col items-center justify-center text-outline pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined">calendar_today</span>
<span class="font-label-bold text-label-bold">Planner</span>
</a>
<a class="flex flex-col items-center justify-center text-outline pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined">leaderboard</span>
<span class="font-label-bold text-label-bold">Stats</span>
</a>
<a class="flex flex-col items-center justify-center text-outline pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined">group</span>
<span class="font-label-bold text-label-bold">Friends</span>
</a>
</nav>
<script>
        // Generate Heatmap Cells
        const grid = document.getElementById('heatmap-grid');
        const intensityClasses = [
            'bg-surface-container-highest',
            'bg-primary-container/20',
            'bg-primary-container/40',
            'bg-primary-container/60',
            'bg-primary-container',
            'bg-primary'
        ];

        // Last 30 days visualization
        for (let i = 0; i < 30; i++) {
            const cell = document.createElement('div');
            cell.className = 'heatmap-cell';
            
            // Randomly weight higher intensity towards the end (simulating a recent streak)
            let intensity;
            if (i > 20) {
                intensity = Math.floor(Math.random() * 2) + 4; // 4 or 5
            } else if (i > 10) {
                intensity = Math.floor(Math.random() * 3) + 2; // 2, 3, or 4
            } else {
                intensity = Math.floor(Math.random() * 4); // 0, 1, 2, or 3
            }
            
            cell.classList.add(intensityClasses[intensity]);
            grid.appendChild(cell);
        }

        // Add micro-interaction for buttons
        document.querySelectorAll('.chunky-button-press').forEach(button => {
            button.addEventListener('touchstart', () => {
                button.style.transform = 'translateY(4px)';
                button.style.boxShadow = 'none';
            });
            button.addEventListener('touchend', () => {
                button.style.transform = 'translateY(0px)';
            });
        });
    </script>
</body></html>

<!-- Friends -->
<!DOCTYPE html>

<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Quest Log - Friends &amp; Social</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@700;800&amp;family=Be+Vietnam+Pro:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .chunky-shadow {
            box-shadow: 0 4px 0 0 var(--tw-shadow-color);
        }
        .chunky-shadow-lg {
            box-shadow: 0 6px 0 0 var(--tw-shadow-color);
        }
        .active-press:active {
            transform: translateY(4px);
            box-shadow: 0 0px 0 0 var(--tw-shadow-color);
        }
        .active-press-lg:active {
            transform: translateY(6px);
            box-shadow: 0 0px 0 0 var(--tw-shadow-color);
        }
        body {
            background-color: #fbf9f9;
            -webkit-tap-highlight-color: transparent;
        }
    </style>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "primary-fixed-dim": "#6be026",
                        "background": "#fbf9f9",
                        "surface-container-low": "#f5f3f3",
                        "inverse-surface": "#303031",
                        "surface": "#fbf9f9",
                        "on-background": "#1b1c1c",
                        "outline-variant": "#becbb1",
                        "on-surface-variant": "#3f4a36",
                        "surface-container-lowest": "#ffffff",
                        "on-tertiary-fixed-variant": "#004c6e",
                        "secondary-fixed-dim": "#ffb872",
                        "tertiary-fixed-dim": "#88ceff",
                        "primary-container": "#58cc02",
                        "surface-dim": "#dbdad9",
                        "on-primary-fixed-variant": "#1f5100",
                        "on-error": "#ffffff",
                        "secondary-fixed": "#ffdcbf",
                        "secondary-container": "#fd9500",
                        "on-secondary-fixed-variant": "#6a3b00",
                        "on-tertiary": "#ffffff",
                        "surface-container-highest": "#e3e2e2",
                        "on-surface": "#1b1c1c",
                        "on-error-container": "#93000a",
                        "tertiary-fixed": "#c8e6ff",
                        "secondary": "#8c5000",
                        "primary-fixed": "#87fe45",
                        "celebratory-purple": "#CE82FF",
                        "on-primary-fixed": "#082100",
                        "on-primary-container": "#1e5000",
                        "on-secondary-fixed": "#2d1600",
                        "surface-variant": "#e3e2e2",
                        "error-container": "#ffdad6",
                        "surface-container-high": "#e9e8e7",
                        "on-tertiary-fixed": "#001e2e",
                        "border-depth": "rgba(0, 0, 0, 0.2)",
                        "error-red": "#FF4B4B",
                        "tertiary": "#006590",
                        "surface-card": "#FFFFFF",
                        "surface-bg": "#F7F7F7",
                        "inverse-on-surface": "#f2f0f0",
                        "inverse-primary": "#6be026",
                        "primary": "#2b6c00",
                        "on-secondary-container": "#633700",
                        "outline": "#6f7b64",
                        "surface-bright": "#fbf9f9",
                        "surface-container": "#efeded",
                        "surface-tint": "#2b6c00",
                        "on-secondary": "#ffffff",
                        "error": "#ba1a1a",
                        "tertiary-container": "#4abdff",
                        "on-tertiary-container": "#004a6b",
                        "on-primary": "#ffffff"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "margin-mobile": "16px",
                        "margin-desktop": "32px",
                        "gutter": "12px",
                        "stack-md": "16px",
                        "base-unit": "4px",
                        "stack-sm": "8px",
                        "stack-lg": "24px"
                    },
                    "fontFamily": {
                        "label-sm": ["Be Vietnam Pro"],
                        "headline-lg-mobile": ["Plus Jakarta Sans"],
                        "label-bold": ["Be Vietnam Pro"],
                        "headline-lg": ["Plus Jakarta Sans"],
                        "display-hero": ["Plus Jakarta Sans"],
                        "body-lg": ["Be Vietnam Pro"],
                        "headline-md": ["Plus Jakarta Sans"],
                        "body-md": ["Be Vietnam Pro"]
                    },
                    "fontSize": {
                        "label-sm": ["13px", {"lineHeight": "18px", "fontWeight": "400"}],
                        "headline-lg-mobile": ["24px", {"lineHeight": "30px", "fontWeight": "800"}],
                        "label-bold": ["14px", {"lineHeight": "20px", "letterSpacing": "0.05em", "fontWeight": "700"}],
                        "headline-lg": ["28px", {"lineHeight": "34px", "fontWeight": "800"}],
                        "display-hero": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "800"}],
                        "body-lg": ["18px", {"lineHeight": "26px", "fontWeight": "500"}],
                        "headline-md": ["20px", {"lineHeight": "26px", "fontWeight": "700"}],
                        "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "500"}]
                    }
                }
            }
        }
    </script>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-background text-on-surface min-h-screen pb-32">
<!-- TopAppBar -->
<header class="fixed top-0 w-full z-50 bg-surface dark:bg-on-surface border-b-4 border-surface-container-high dark:border-surface-dim flex justify-between items-center px-margin-mobile h-16">
<div class="flex items-center gap-3">
<div class="w-10 h-10 rounded-full border-2 border-primary-container overflow-hidden">
<img class="w-full h-full object-cover" data-alt="A stylized 3D avatar of a friendly user wearing a tiny golden crown, rendered in a vibrant and playful digital art style consistent with a game-like social app. The lighting is soft and cheerful, with a clean light grey background to maintain a high-energy and encouraging visual identity." src="https://lh3.googleusercontent.com/aida-public/AB6AXuBWfH5OedTAzBT_lfyWMsE7mhWbIavX4RhG-rkDFGdi0cEOdoovC-CDjY1mLm3BLH2xFNjZvGjNbMIWiL38_DsDXCCmaOeZXIhFQP9N8EsPuwC497aSOVglTeStep8fMf9BeclBYn56YbEgzQMZmYVW0J1Q_DXtAq1YaPEqagPWMoN-rzidTVUUv_hu9lq94mCxdZ5marzQ-dLfk1IJbp0jehjkXGCiLn8kCkKnilA5_dBJ1N7aAdCbWfM7KoHZo3MWLxeBa-UwoK7i"/>
</div>
<h1 class="font-headline-lg-mobile text-headline-lg-mobile text-primary tracking-tighter uppercase">QUEST LOG</h1>
</div>
<button class="text-primary hover:opacity-80 active:translate-y-1 transition-transform">
<span class="material-symbols-outlined" data-icon="local_fire_department" style="font-variation-settings: 'FILL' 1;">local_fire_department</span>
</button>
</header>
<main class="mt-20 px-margin-mobile space-y-stack-lg">
<!-- Find Friends Search -->
<section>
<div class="relative group">
<div class="absolute inset-y-0 left-4 flex items-center pointer-events-none text-outline">
<span class="material-symbols-outlined" data-icon="search">search</span>
</div>
<input class="w-full bg-surface-container border-2 border-surface-container-highest rounded-xl py-4 pl-12 pr-4 font-body-md text-body-md focus:outline-none focus:border-primary-container transition-colors shadow-[0_4px_0_0_#e3e2e2]" placeholder="Find friends..." type="text"/>
</div>
</section>
<!-- Stats Quick Look (Horizontal Scroll) -->
<section class="flex gap-gutter overflow-x-auto pb-4 -mx-margin-mobile px-margin-mobile no-scrollbar">
<div class="min-w-[140px] bg-secondary-fixed rounded-2xl p-4 border-2 border-secondary chunky-shadow shadow-secondary active-press active-press-lg transition-all">
<span class="material-symbols-outlined text-secondary" data-icon="stars" style="font-variation-settings: 'FILL' 1;">stars</span>
<p class="font-label-bold text-label-bold text-secondary mt-2">Quest Points</p>
<h2 class="font-headline-lg text-headline-lg text-on-secondary-fixed">2,450</h2>
</div>
<div class="min-w-[140px] bg-primary-fixed rounded-2xl p-4 border-2 border-primary chunky-shadow shadow-primary active-press active-press-lg transition-all">
<span class="material-symbols-outlined text-primary" data-icon="bolt" style="font-variation-settings: 'FILL' 1;">bolt</span>
<p class="font-label-bold text-label-bold text-primary mt-2">Active Streak</p>
<h2 class="font-headline-lg text-headline-lg text-on-primary-fixed">12 Days</h2>
</div>
<div class="min-w-[140px] bg-tertiary-fixed rounded-2xl p-4 border-2 border-tertiary chunky-shadow shadow-tertiary active-press active-press-lg transition-all">
<span class="material-symbols-outlined text-tertiary" data-icon="emoji_events" style="font-variation-settings: 'FILL' 1;">emoji_events</span>
<p class="font-label-bold text-label-bold text-tertiary mt-2">Badges</p>
<h2 class="font-headline-lg text-headline-lg text-on-tertiary-fixed">8</h2>
</div>
</section>
<!-- Leaderboard (Bento Style) -->
<section class="space-y-stack-md">
<div class="flex justify-between items-end">
<h3 class="font-headline-md text-headline-md">Weekly Leaderboard</h3>
<button class="text-primary font-label-bold text-label-bold">View All</button>
</div>
<div class="bg-surface-container-low rounded-3xl p-4 border-2 border-outline-variant chunky-shadow shadow-outline-variant">
<div class="space-y-3">
<!-- Rank 1 -->
<div class="flex items-center gap-4 bg-white p-3 rounded-2xl border-2 border-surface-container-highest chunky-shadow shadow-surface-container-highest">
<div class="w-8 h-8 flex items-center justify-center bg-secondary-container rounded-full text-white font-label-bold">1</div>
<div class="w-10 h-10 rounded-full overflow-hidden border-2 border-secondary-container">
<img class="w-full h-full object-cover" data-alt="A profile photo of a young woman with a joyful expression, wearing sporty glasses, rendered in a 3D clay-like animation style. The lighting is warm and sunset-like, emphasizing a sense of achievement and community within a playful, gamified application environment." src="https://lh3.googleusercontent.com/aida-public/AB6AXuACEZ1WBKs4GvsBmzcVy6P3DDYG7L4JLGmM0y-Cm6Xp5lQa3jQ_mxs2XU7o7a1cLaq04a65jDuyWx6ortg5RqP9A8EjHJDFh5oocsu7Qn7-MFMXxhC26tVyIz9wWk4rq-Py1a9XsyIyXmxpOUhKIyQM44KyV36Iuxwhuh0uR0ddoThFnibsOQTAE2EdRvcE3yuolsFVCiP_Wqkp4LTjSgL3GpSzOrSHK4eP0gkkv6XT5xoMXW6CqRhK-EahuLdTQTLMtw7GPEfP4e7S"/>
</div>
<div class="flex-1">
<p class="font-label-bold text-label-bold">Alex Rivera</p>
<p class="text-xs text-outline">12,400 pts</p>
</div>
<div class="flex items-center gap-1 text-secondary">
<span class="material-symbols-outlined text-sm" data-icon="local_fire_department" style="font-variation-settings: 'FILL' 1;">local_fire_department</span>
<span class="font-label-bold">42</span>
</div>
</div>
<!-- Rank 2 -->
<div class="flex items-center gap-4 bg-white p-3 rounded-2xl border-2 border-surface-container-highest chunky-shadow shadow-surface-container-highest">
<div class="w-8 h-8 flex items-center justify-center bg-surface-container-highest rounded-full text-on-surface-variant font-label-bold">2</div>
<div class="w-10 h-10 rounded-full overflow-hidden border-2 border-primary-container">
<img class="w-full h-full object-cover" data-alt="A portrait of a cheerful man with curly hair and a green hoodie, created in a premium 3D digital art style. The character is set against a vibrant green background, reflecting a high-energy, encouraging user interface theme for a productivity app." src="https://lh3.googleusercontent.com/aida-public/AB6AXuDWJtltf9LyNby49oR2OYbyAstu64ao2GI0yTSS8rfE2oH7HjnXlqpItpPrFzQct_hnnK8d4Y9z5TEeJBdBYGdUwDMpQYyPDUCD6B_X9M26Cqn2pRLlIMRytL_6iu9i-7Uz2MwpoomeFwGOVv9Yv6JYh-xD5f9n5SlHfhz01o4f0JoFbNQfsmoUbG0C6AzaxBUBPcMLeQpjlqOuXom7qzw3hzl4zl2368619Wg1hpJN01TLeyatlznd23K2bp1h87flCQut1hiTGzlQ"/>
</div>
<div class="flex-1">
<p class="font-label-bold text-label-bold">Jordan Lee</p>
<p class="text-xs text-outline">10,150 pts</p>
</div>
<div class="flex items-center gap-1 text-primary">
<span class="material-symbols-outlined text-sm" data-icon="local_fire_department" style="font-variation-settings: 'FILL' 1;">local_fire_department</span>
<span class="font-label-bold">28</span>
</div>
</div>
</div>
</div>
</section>
<!-- Friends Activities -->
<section class="space-y-stack-md">
<h3 class="font-headline-md text-headline-md">Recent Achievements</h3>
<div class="space-y-4">
<!-- Activity Card 1 -->
<div class="bg-white rounded-3xl p-5 border-2 border-surface-container-highest chunky-shadow shadow-surface-container-highest space-y-4">
<div class="flex items-center gap-4">
<div class="w-12 h-12 rounded-full overflow-hidden border-2 border-celebratory-purple">
<img class="w-full h-full object-cover" data-alt="A vibrant 3D stylized character with bright blue hair and a huge smile, set in a brightly lit digital space with purple accents. The style is bold and chunky, designed to feel tactile and responsive like a modern handheld game interface." src="https://lh3.googleusercontent.com/aida-public/AB6AXuB8woGpjJatAxyCgA2o9DswLyh-rHj_VhmTxnmdG1dR-HVIKUoxEZdkJH3AzU6TsOPPbPz9ZAy3NEQoqWKlWI52e4pwSt0NLyRKRp67crGlnTuisL62mScDU-MUGTkyDTOgKdhbxuf69dcQJR0VkUjpc9Rgspci9feRXWxzHNQYDVbJkcfZiZWxhauGsBZ9tj4Y69acj3XfOJn7Z7qMtn0kXjKimOy5YUfNwisFR1Dc6NvKEuLKva8NoOYuiKIx8AollxtQIbFCjpju"/>
</div>
<div class="flex-1">
<p class="font-body-md text-body-md"><span class="font-label-bold">Sarah Chen</span> earned the <span class="text-celebratory-purple font-label-bold">Early Bird</span> badge!</p>
<p class="text-xs text-outline">2 hours ago</p>
</div>
</div>
<div class="bg-surface-container-lowest p-3 rounded-2xl border border-surface-container flex items-center gap-3">
<div class="w-10 h-10 bg-celebratory-purple/10 rounded-xl flex items-center justify-center">
<span class="material-symbols-outlined text-celebratory-purple" data-icon="wb_sunny" style="font-variation-settings: 'FILL' 1;">wb_sunny</span>
</div>
<div>
<p class="text-xs font-label-bold uppercase text-celebratory-purple tracking-wider">New Badge</p>
<p class="font-label-bold text-label-bold">Early Bird Lv. 3</p>
</div>
</div>
<div class="flex gap-2">
<button class="flex-1 flex items-center justify-center gap-2 bg-background border-2 border-surface-container-highest py-2 rounded-xl chunky-shadow shadow-surface-container-highest active-press transition-all hover:bg-surface-container-low" onclick="cheer(this)">
<span class="material-symbols-outlined text-secondary" data-icon="local_fire_department" style="font-variation-settings: 'FILL' 1;">local_fire_department</span>
<span class="font-label-bold text-label-bold">Cheer</span>
</button>
<button class="flex items-center justify-center w-12 bg-background border-2 border-surface-container-highest rounded-xl chunky-shadow shadow-surface-container-highest active-press transition-all">
<span>👏</span>
</button>
</div>
</div>
<!-- Activity Card 2 -->
<div class="bg-white rounded-3xl p-5 border-2 border-surface-container-highest chunky-shadow shadow-surface-container-highest space-y-4">
<div class="flex items-center gap-4">
<div class="w-12 h-12 rounded-full overflow-hidden border-2 border-primary-container">
<img class="w-full h-full object-cover" data-alt="A portrait of a playful digital character with a bright yellow hat and friendly features, rendered in a high-contrast 3D art style. The character is placed against a light, clean studio lighting setup to maintain a professional and encouraging social app aesthetic." src="https://lh3.googleusercontent.com/aida-public/AB6AXuAp8r6lTIfOqEwWVY-zEsgIVc-QfRbKZefgUrBxharFsU5GzUWM50Bu7gC8OEwZc15CbA4KvfUxPmwddwGd0kI7VoiA-ubEu83Z__7RnXCYoiJnZXH6X6_sTVsV0ud5_UBclZPJ1caZZyZiXiDd_GAwKhQzSHaUqP9Ge8V1Yc1TR4j9LZjPZE89-XEpBd9ZYYXnrfbmaSMEULE4O2MCU4USGR_zR8sAlcr6xTcwtFyXxsN29zHPladcLkzwLNlSe88xIRH8HwH50VaP"/>
</div>
<div class="flex-1">
<p class="font-body-md text-body-md"><span class="font-label-bold">Mika</span> hit a <span class="text-primary font-label-bold">30 Day Streak</span>!</p>
<p class="text-xs text-outline">5 hours ago</p>
</div>
</div>
<div class="flex gap-2">
<button class="flex-1 flex items-center justify-center gap-2 bg-background border-2 border-surface-container-highest py-2 rounded-xl chunky-shadow shadow-surface-container-highest active-press transition-all hover:bg-surface-container-low" onclick="cheer(this)">
<span class="material-symbols-outlined text-secondary" data-icon="celebration" style="font-variation-settings: 'FILL' 1;">celebration</span>
<span class="font-label-bold text-label-bold">Celebrate</span>
</button>
<button class="flex items-center justify-center w-12 bg-background border-2 border-surface-container-highest rounded-xl chunky-shadow shadow-surface-container-highest active-press transition-all">
<span>🔥</span>
</button>
</div>
</div>
</div>
</section>
</main>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 w-full z-50 rounded-t-xl bg-surface dark:bg-inverse-surface border-t-4 border-surface-container-high dark:border-surface-dim flex justify-around items-end pb-4 px-2 h-20">
<!-- Today -->
<a class="flex flex-col items-center justify-center text-outline dark:text-outline-variant pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined" data-icon="bolt">bolt</span>
<span class="font-label-bold text-label-bold">Today</span>
</a>
<!-- Planner -->
<a class="flex flex-col items-center justify-center text-outline dark:text-outline-variant pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined" data-icon="calendar_today">calendar_today</span>
<span class="font-label-bold text-label-bold">Planner</span>
</a>
<!-- Stats -->
<a class="flex flex-col items-center justify-center text-outline dark:text-outline-variant pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined" data-icon="leaderboard">leaderboard</span>
<span class="font-label-bold text-label-bold">Stats</span>
</a>
<!-- Friends (ACTIVE) -->
<a class="flex flex-col items-center justify-center text-primary dark:text-primary-fixed border-t-4 border-primary dark:border-primary-fixed pt-2 active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined" data-icon="group" style="font-variation-settings: 'FILL' 1;">group</span>
<span class="font-label-bold text-label-bold">Friends</span>
</a>
</nav>
<script>
        function cheer(btn) {
            const originalText = btn.querySelector('.font-label-bold').innerText;
            const originalIcon = btn.querySelector('.material-symbols-outlined').innerText;
            
            btn.classList.add('bg-primary-fixed-dim', 'border-primary');
            btn.querySelector('.font-label-bold').innerText = 'Sent!';
            btn.querySelector('.material-symbols-outlined').innerText = 'check_circle';
            
            // Temporary celebration effect
            const container = btn.closest('div');
            const particle = document.createElement('div');
            particle.innerHTML = '🎉';
            particle.className = 'absolute pointer-events-none transition-all duration-700 ease-out';
            particle.style.left = '50%';
            particle.style.top = '0';
            btn.appendChild(particle);
            
            setTimeout(() => {
                particle.style.transform = 'translateY(-50px) scale(1.5)';
                particle.style.opacity = '0';
            }, 10);

            setTimeout(() => {
                btn.classList.remove('bg-primary-fixed-dim', 'border-primary');
                btn.querySelector('.font-label-bold').innerText = originalText;
                btn.querySelector('.material-symbols-outlined').innerText = originalIcon;
                particle.remove();
            }, 2000);
        }

        // Search highlight logic
        const searchInput = document.querySelector('input');
        searchInput.addEventListener('focus', () => {
            searchInput.parentElement.classList.add('scale-[1.02]');
            searchInput.parentElement.classList.remove('shadow-[0_4px_0_0_#e3e2e2]');
            searchInput.parentElement.style.boxShadow = '0 6px 0 0 #58cc02';
        });
        searchInput.addEventListener('blur', () => {
            searchInput.parentElement.classList.remove('scale-[1.02]');
            searchInput.parentElement.style.boxShadow = '0 4px 0 0 #e3e2e2';
        });
    </script>
</body></html>

<!-- Stats & Insights -->
<!DOCTYPE html>

<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Quest Log - Stats &amp; Insights</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&amp;family=Be+Vietnam+Pro:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<!-- Tailwind Config Verbatim -->
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
                    "primary-fixed-dim": "#6be026",
                    "background": "#fbf9f9",
                    "surface-container-low": "#f5f3f3",
                    "inverse-surface": "#303031",
                    "surface": "#fbf9f9",
                    "on-background": "#1b1c1c",
                    "outline-variant": "#becbb1",
                    "on-surface-variant": "#3f4a36",
                    "surface-container-lowest": "#ffffff",
                    "on-tertiary-fixed-variant": "#004c6e",
                    "secondary-fixed-dim": "#ffb872",
                    "tertiary-fixed-dim": "#88ceff",
                    "primary-container": "#58cc02",
                    "surface-dim": "#dbdad9",
                    "on-primary-fixed-variant": "#1f5100",
                    "on-error": "#ffffff",
                    "secondary-fixed": "#ffdcbf",
                    "secondary-container": "#fd9500",
                    "on-secondary-fixed-variant": "#6a3b00",
                    "on-tertiary": "#ffffff",
                    "surface-container-highest": "#e3e2e2",
                    "on-surface": "#1b1c1c",
                    "on-error-container": "#93000a",
                    "tertiary-fixed": "#c8e6ff",
                    "secondary": "#8c5000",
                    "primary-fixed": "#87fe45",
                    "celebratory-purple": "#CE82FF",
                    "on-primary-fixed": "#082100",
                    "on-primary-container": "#1e5000",
                    "on-secondary-fixed": "#2d1600",
                    "surface-variant": "#e3e2e2",
                    "error-container": "#ffdad6",
                    "surface-container-high": "#e9e8e7",
                    "on-tertiary-fixed": "#001e2e",
                    "border-depth": "rgba(0, 0, 0, 0.2)",
                    "error-red": "#FF4B4B",
                    "tertiary": "#006590",
                    "surface-card": "#FFFFFF",
                    "surface-bg": "#F7F7F7",
                    "inverse-on-surface": "#f2f0f0",
                    "inverse-primary": "#6be026",
                    "primary": "#2b6c00",
                    "on-secondary-container": "#633700",
                    "outline": "#6f7b64",
                    "surface-bright": "#fbf9f9",
                    "surface-container": "#efeded",
                    "surface-tint": "#2b6c00",
                    "on-secondary": "#ffffff",
                    "error": "#ba1a1a",
                    "tertiary-container": "#4abdff",
                    "on-tertiary-container": "#004a6b",
                    "on-primary": "#ffffff"
            },
            "borderRadius": {
                    "DEFAULT": "0.25rem",
                    "lg": "0.5rem",
                    "xl": "0.75rem",
                    "full": "9999px"
            },
            "spacing": {
                    "margin-mobile": "16px",
                    "margin-desktop": "32px",
                    "gutter": "12px",
                    "stack-md": "16px",
                    "base-unit": "4px",
                    "stack-sm": "8px",
                    "stack-lg": "24px"
            },
            "fontFamily": {
                    "label-sm": ["Be Vietnam Pro"],
                    "headline-lg-mobile": ["Plus Jakarta Sans"],
                    "label-bold": ["Be Vietnam Pro"],
                    "headline-lg": ["Plus Jakarta Sans"],
                    "display-hero": ["Plus Jakarta Sans"],
                    "body-lg": ["Be Vietnam Pro"],
                    "headline-md": ["Plus Jakarta Sans"],
                    "body-md": ["Be Vietnam Pro"]
            },
            "fontSize": {
                    "label-sm": ["13px", {"lineHeight": "18px", "fontWeight": "400"}],
                    "headline-lg-mobile": ["24px", {"lineHeight": "30px", "fontWeight": "800"}],
                    "label-bold": ["14px", {"lineHeight": "20px", "letterSpacing": "0.05em", "fontWeight": "700"}],
                    "headline-lg": ["28px", {"lineHeight": "34px", "fontWeight": "800"}],
                    "display-hero": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "800"}],
                    "body-lg": ["18px", {"lineHeight": "26px", "fontWeight": "500"}],
                    "headline-md": ["20px", {"lineHeight": "26px", "fontWeight": "700"}],
                    "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "500"}]
            }
          },
        },
      }
    </script>
<style>
        .chunky-shadow {
            box-shadow: 0 4px 0 0 var(--tw-shadow-color, #e3e2e2);
        }
        .chunky-shadow-active {
            box-shadow: 0 0px 0 0 transparent;
            transform: translateY(4px);
        }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            -webkit-tap-highlight-color: transparent;
        }
        .hide-scrollbar::-webkit-scrollbar {
            display: none;
        }
        .hide-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-background text-on-background min-h-screen pb-32">
<!-- TopAppBar -->
<header class="fixed top-0 w-full z-50 bg-surface dark:bg-on-surface border-b-4 border-surface-container-high dark:border-surface-dim flex justify-between items-center px-margin-mobile h-16">
<div class="flex items-center gap-3">
<div class="w-10 h-10 rounded-full border-2 border-primary-container overflow-hidden">
<img class="w-full h-full object-cover" data-alt="A whimsical digital avatar of a young adventurer wearing a golden celebratory crown. The character has a playful expression, set against a vibrant green background. The art style is clean and 3D-tactile, reminiscent of high-end mobile gaming graphics with soft studio lighting and bold primary colors." src="https://lh3.googleusercontent.com/aida-public/AB6AXuCg_5lo_wD4iaAneWLDOj4RcdDQ8CVFaMgCVrTIp2fCo6hRn36Nn-yRic-CpQvaFko0SPUxJTbBfIcA9icDjH1d7XjcC0Hy-W7ElDW5z8hkuhy1qPf2H7ygjrxewZCSMSs79bSLNvF0r8zcuiMJB34Ak2OLRzSMi_47lAs4aBoFInwPqZdQ4PuQ5LN82u8hSO4vrTlpDsxaqrPSk2BmoOHDaM3n8wufQc09NAC-XfxR_hxnoQmcmak8dXieWTdj3c2FO_WmBwDsxeBm"/>
</div>
<h1 class="font-headline-lg-mobile text-headline-lg-mobile text-primary tracking-tighter uppercase">QUEST LOG</h1>
</div>
<button class="text-primary dark:text-primary-fixed hover:opacity-80 active:translate-y-1 transition-transform">
<span class="material-symbols-outlined text-3xl">local_fire_department</span>
</button>
</header>
<main class="pt-24 px-margin-mobile max-w-2xl mx-auto space-y-stack-lg">
<!-- Hero Streak Section -->
<section class="bg-surface-container-lowest rounded-xl border-2 border-surface-container-high chunky-shadow shadow-surface-container-high p-stack-md flex items-center justify-between overflow-hidden relative">
<div class="z-10">
<p class="font-label-bold text-label-bold text-outline uppercase tracking-widest mb-1">Current Streak</p>
<div class="flex items-baseline gap-2">
<span class="font-display-hero text-display-hero text-secondary-container">14</span>
<span class="font-headline-md text-headline-md text-secondary">DAYS</span>
</div>
</div>
<div class="absolute right-[-20px] top-[-10px] opacity-20">
<span class="material-symbols-outlined text-[120px] text-secondary-container" style="font-variation-settings: 'FILL' 1;">local_fire_department</span>
</div>
<div class="bg-secondary-fixed text-on-secondary-fixed-variant px-4 py-2 rounded-full border-2 border-secondary font-label-bold text-label-bold z-10">
                Level 12 Warrior
            </div>
</section>
<!-- Insights Grid -->
<div class="grid grid-cols-2 gap-gutter">
<div class="bg-surface-card rounded-xl border-2 border-surface-container-high chunky-shadow shadow-surface-container-high p-stack-md">
<div class="flex items-center gap-2 mb-2">
<span class="material-symbols-outlined text-primary" style="font-variation-settings: 'FILL' 1;">verified</span>
<p class="font-label-bold text-label-bold text-outline">Completed</p>
</div>
<p class="font-display-hero text-[32px] leading-tight text-on-surface">128</p>
<p class="font-label-sm text-label-sm text-primary">+12 this week</p>
</div>
<div class="bg-surface-card rounded-xl border-2 border-surface-container-high chunky-shadow shadow-surface-container-high p-stack-md">
<div class="flex items-center gap-2 mb-2">
<span class="material-symbols-outlined text-celebratory-purple" style="font-variation-settings: 'FILL' 1;">workspace_premium</span>
<p class="font-label-bold text-label-bold text-outline">Best Streak</p>
</div>
<p class="font-display-hero text-[32px] leading-tight text-on-surface">24</p>
<p class="font-label-sm text-label-sm text-outline">Personal Record</p>
</div>
</div>
<!-- Completion Chart Section -->
<section class="bg-surface-card rounded-xl border-2 border-surface-container-high chunky-shadow shadow-surface-container-high p-stack-md">
<div class="flex justify-between items-center mb-6">
<h2 class="font-headline-md text-headline-md text-on-surface">Weekly Progress</h2>
<div class="bg-surface-container px-3 py-1 rounded-full border-2 border-outline-variant font-label-bold text-[12px] uppercase">
                    Last 7 Days
                </div>
</div>
<div class="flex items-end justify-between h-40 gap-2 mb-4">
<!-- Chart Bars -->
<div class="flex-1 flex flex-col items-center gap-2">
<div class="w-full bg-primary-container rounded-t-lg transition-all hover:brightness-110" style="height: 60%;"></div>
<span class="font-label-sm text-label-sm text-outline">M</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2">
<div class="w-full bg-primary-container rounded-t-lg transition-all hover:brightness-110" style="height: 85%;"></div>
<span class="font-label-sm text-label-sm text-outline">T</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2">
<div class="w-full bg-primary-container rounded-t-lg transition-all hover:brightness-110" style="height: 45%;"></div>
<span class="font-label-sm text-label-sm text-outline">W</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2">
<div class="w-full bg-primary-container rounded-t-lg transition-all hover:brightness-110" style="height: 95%;"></div>
<span class="font-label-sm text-label-sm text-outline">T</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2">
<div class="w-full bg-primary-container rounded-t-lg transition-all hover:brightness-110" style="height: 70%;"></div>
<span class="font-label-sm text-label-sm text-outline">F</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2">
<div class="w-full bg-primary-container rounded-t-lg transition-all hover:brightness-110 border-2 border-dashed border-primary" style="height: 30%;"></div>
<span class="font-label-sm text-label-sm text-primary font-bold">S</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2">
<div class="w-full bg-surface-container-highest rounded-t-lg" style="height: 10%;"></div>
<span class="font-label-sm text-label-sm text-outline">S</span>
</div>
</div>
<div class="flex items-center gap-4 bg-primary-fixed p-3 rounded-xl border-2 border-primary">
<span class="material-symbols-outlined text-primary-container text-4xl" style="font-variation-settings: 'FILL' 1;">trending_up</span>
<div>
<p class="font-label-bold text-label-bold text-on-primary-fixed">You're crushing it!</p>
<p class="font-label-sm text-label-sm text-on-primary-fixed-variant">82% average completion this week.</p>
</div>
</div>
</section>
<!-- Category Breakdown -->
<section class="space-y-stack-md">
<h2 class="font-headline-md text-headline-md text-on-surface">Quest Categories</h2>
<div class="grid grid-cols-1 gap-stack-sm">
<!-- Health -->
<div class="bg-surface-card rounded-xl border-2 border-surface-container-high p-4 flex items-center gap-4 chunky-shadow shadow-surface-container-high active:translate-y-1 transition-all cursor-pointer">
<div class="w-12 h-12 bg-error-container rounded-xl border-2 border-error-red flex items-center justify-center text-error-red">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">favorite</span>
</div>
<div class="flex-1">
<div class="flex justify-between items-end mb-1">
<h3 class="font-body-lg text-body-lg font-bold">Health</h3>
<span class="font-label-bold text-label-bold text-outline">92%</span>
</div>
<div class="h-4 w-full bg-surface-container-highest rounded-full overflow-hidden border-2 border-surface-container-high">
<div class="h-full bg-error-red rounded-full" style="width: 92%"></div>
</div>
</div>
</div>
<!-- Work -->
<div class="bg-surface-card rounded-xl border-2 border-surface-container-high p-4 flex items-center gap-4 chunky-shadow shadow-surface-container-high active:translate-y-1 transition-all cursor-pointer">
<div class="w-12 h-12 bg-tertiary-container rounded-xl border-2 border-tertiary flex items-center justify-center text-on-tertiary-container">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">work</span>
</div>
<div class="flex-1">
<div class="flex justify-between items-end mb-1">
<h3 class="font-body-lg text-body-lg font-bold">Work</h3>
<span class="font-label-bold text-label-bold text-outline">68%</span>
</div>
<div class="h-4 w-full bg-surface-container-highest rounded-full overflow-hidden border-2 border-surface-container-high">
<div class="h-full bg-tertiary-container rounded-full" style="width: 68%"></div>
</div>
</div>
</div>
<!-- Social -->
<div class="bg-surface-card rounded-xl border-2 border-surface-container-high p-4 flex items-center gap-4 chunky-shadow shadow-surface-container-high active:translate-y-1 transition-all cursor-pointer">
<div class="w-12 h-12 bg-secondary-fixed rounded-xl border-2 border-secondary flex items-center justify-center text-on-secondary-container">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">groups</span>
</div>
<div class="flex-1">
<div class="flex justify-between items-end mb-1">
<h3 class="font-body-lg text-body-lg font-bold">Social</h3>
<span class="font-label-bold text-label-bold text-outline">45%</span>
</div>
<div class="h-4 w-full bg-surface-container-highest rounded-full overflow-hidden border-2 border-surface-container-high">
<div class="h-full bg-secondary-container rounded-full" style="width: 45%"></div>
</div>
</div>
</div>
<!-- Mind -->
<div class="bg-surface-card rounded-xl border-2 border-surface-container-high p-4 flex items-center gap-4 chunky-shadow shadow-surface-container-high active:translate-y-1 transition-all cursor-pointer">
<div class="w-12 h-12 bg-primary-fixed rounded-xl border-2 border-primary flex items-center justify-center text-on-primary-container">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">psychology</span>
</div>
<div class="flex-1">
<div class="flex justify-between items-end mb-1">
<h3 class="font-body-lg text-body-lg font-bold">Mind</h3>
<span class="font-label-bold text-label-bold text-outline">76%</span>
</div>
<div class="h-4 w-full bg-surface-container-highest rounded-full overflow-hidden border-2 border-surface-container-high">
<div class="h-full bg-primary-container rounded-full" style="width: 76%"></div>
</div>
</div>
</div>
</div>
</section>
<!-- Achievement Preview Card -->
<section class="bg-celebratory-purple bg-opacity-10 border-4 border-dashed border-celebratory-purple rounded-2xl p-6 text-center space-y-4">
<div class="relative inline-block">
<span class="material-symbols-outlined text-[64px] text-celebratory-purple" style="font-variation-settings: 'FILL' 1;">military_tech</span>
<div class="absolute -top-2 -right-2 bg-white rounded-full p-1 border-2 border-celebratory-purple">
<span class="material-symbols-outlined text-primary text-sm" style="font-variation-settings: 'FILL' 1;">check_circle</span>
</div>
</div>
<div>
<h3 class="font-headline-md text-headline-md text-on-surface">Almost there!</h3>
<p class="font-body-md text-body-md text-outline">Complete 3 more quests to unlock the 'Consistency King' badge.</p>
</div>
<button class="w-full bg-celebratory-purple text-white py-3 rounded-xl font-label-bold text-label-bold uppercase border-b-4 border-purple-800 active:border-b-0 active:translate-y-1 transition-all">
                View All Achievements
            </button>
</section>
</main>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 w-full z-50 bg-surface dark:bg-inverse-surface border-t-4 border-surface-container-high dark:border-surface-dim rounded-t-xl flex justify-around items-end pb-4 px-2">
<!-- Today -->
<a class="flex flex-col items-center justify-center text-outline dark:text-outline-variant pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined">bolt</span>
<span class="font-label-bold text-label-bold">Today</span>
</a>
<!-- Planner -->
<a class="flex flex-col items-center justify-center text-outline dark:text-outline-variant pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined">calendar_today</span>
<span class="font-label-bold text-label-bold">Planner</span>
</a>
<!-- Stats (Active) -->
<a class="flex flex-col items-center justify-center text-primary dark:text-primary-fixed border-t-4 border-primary dark:border-primary-fixed pt-2 active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">leaderboard</span>
<span class="font-label-bold text-label-bold">Stats</span>
</a>
<!-- Friends -->
<a class="flex flex-col items-center justify-center text-outline dark:text-outline-variant pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined">group</span>
<span class="font-label-bold text-label-bold">Friends</span>
</a>
</nav>
<script>
        // Micro-interactions for buttons and cards
        document.querySelectorAll('.chunky-shadow').forEach(card => {
            card.addEventListener('mousedown', () => {
                card.classList.remove('chunky-shadow');
                card.classList.add('chunky-shadow-active');
            });
            card.addEventListener('mouseup', () => {
                card.classList.add('chunky-shadow');
                card.classList.remove('chunky-shadow-active');
            });
            card.addEventListener('mouseleave', () => {
                card.classList.add('chunky-shadow');
                card.classList.remove('chunky-shadow-active');
            });
        });

        // Animation for bar chart heights on load
        window.addEventListener('DOMContentLoaded', () => {
            const bars = document.querySelectorAll('.rounded-t-lg');
            bars.forEach((bar, index) => {
                const targetHeight = bar.style.height;
                bar.style.height = '0%';
                setTimeout(() => {
                    bar.style.transition = 'height 0.8s cubic-bezier(0.34, 1.56, 0.64, 1)';
                    bar.style.height = targetHeight;
                }, 100 + (index * 100));
            });
        });
    </script>
</body></html>

<!-- New Quest -->
<!DOCTYPE html>

<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>New Quest</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@700;800&amp;family=Be+Vietnam+Pro:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .chunky-shadow {
            box-shadow: 0 6px 0 0 var(--tw-shadow-color);
        }
        .chunky-shadow:active {
            box-shadow: 0 0px 0 0 var(--tw-shadow-color);
            transform: translateY(6px);
        }
        .input-chunky-focus:focus-within {
            box-shadow: inset 0 4px 0 0 rgba(0, 0, 0, 0.05);
        }
        /* Custom Time Picker reset for a cleaner look */
        input[type="time"]::-webkit-calendar-picker-indicator {
            background: transparent;
            bottom: 0;
            color: transparent;
            cursor: pointer;
            height: auto;
            left: 0;
            position: absolute;
            right: 0;
            top: 0;
            width: auto;
        }
    </style>
<script id="tailwind-config">
        tailwind.config = {
          darkMode: "class",
          theme: {
            extend: {
              "colors": {
                      "outline-variant": "#becbb1",
                      "primary": "#2b6c00",
                      "on-tertiary-container": "#004a6b",
                      "surface-bg": "#F7F7F7",
                      "secondary-fixed-dim": "#ffb872",
                      "inverse-on-surface": "#f2f0f0",
                      "on-secondary-fixed-variant": "#6a3b00",
                      "on-surface": "#1b1c1c",
                      "error-red": "#FF4B4B",
                      "on-tertiary-fixed-variant": "#004c6e",
                      "on-primary": "#ffffff",
                      "secondary-container": "#fd9500",
                      "surface": "#fbf9f9",
                      "surface-container-low": "#f5f3f3",
                      "on-error": "#ffffff",
                      "surface-bright": "#fbf9f9",
                      "surface-container-high": "#e9e8e7",
                      "error": "#ba1a1a",
                      "on-tertiary-fixed": "#001e2e",
                      "secondary": "#8c5000",
                      "primary-fixed-dim": "#6be026",
                      "tertiary-fixed-dim": "#88ceff",
                      "outline": "#6f7b64",
                      "tertiary-container": "#4abdff",
                      "celebratory-purple": "#CE82FF",
                      "border-depth": "rgba(0, 0, 0, 0.2)",
                      "inverse-primary": "#6be026",
                      "on-primary-container": "#1e5000",
                      "tertiary": "#006590",
                      "surface-container": "#efeded",
                      "on-primary-fixed-variant": "#1f5100",
                      "surface-container-lowest": "#ffffff",
                      "background": "#fbf9f9",
                      "on-primary-fixed": "#082100",
                      "surface-tint": "#2b6c00",
                      "secondary-fixed": "#ffdcbf",
                      "surface-card": "#FFFFFF",
                      "error-container": "#ffdad6",
                      "primary-fixed": "#87fe45",
                      "on-error-container": "#93000a",
                      "on-secondary-fixed": "#2d1600",
                      "surface-dim": "#dbdad9",
                      "on-secondary": "#ffffff",
                      "surface-variant": "#e3e2e2",
                      "on-surface-variant": "#3f4a36",
                      "on-tertiary": "#ffffff",
                      "primary-container": "#58cc02",
                      "surface-container-highest": "#e3e2e2",
                      "on-secondary-container": "#633700",
                      "tertiary-fixed": "#c8e6ff",
                      "inverse-surface": "#303031",
                      "on-background": "#1b1c1c"
              },
              "borderRadius": {
                      "DEFAULT": "0.25rem",
                      "lg": "0.5rem",
                      "xl": "0.75rem",
                      "full": "9999px"
              },
              "spacing": {
                      "stack-sm": "8px",
                      "gutter": "12px",
                      "margin-mobile": "16px",
                      "margin-desktop": "32px",
                      "stack-md": "16px",
                      "base-unit": "4px",
                      "stack-lg": "24px"
              },
              "fontFamily": {
                      "headline-lg-mobile": ["Plus Jakarta Sans"],
                      "label-bold": ["Be Vietnam Pro"],
                      "display-hero": ["Plus Jakarta Sans"],
                      "body-md": ["Be Vietnam Pro"],
                      "body-lg": ["Be Vietnam Pro"],
                      "label-sm": ["Be Vietnam Pro"],
                      "headline-lg": ["Plus Jakarta Sans"],
                      "headline-md": ["Plus Jakarta Sans"]
              },
              "fontSize": {
                      "headline-lg-mobile": ["24px", {"lineHeight": "30px", "fontWeight": "800"}],
                      "label-bold": ["14px", {"lineHeight": "20px", "letterSpacing": "0.05em", "fontWeight": "700"}],
                      "display-hero": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "800"}],
                      "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "500"}],
                      "body-lg": ["18px", {"lineHeight": "26px", "fontWeight": "500"}],
                      "label-sm": ["13px", {"lineHeight": "18px", "fontWeight": "400"}],
                      "headline-lg": ["28px", {"lineHeight": "34px", "fontWeight": "800"}],
                      "headline-md": ["20px", {"lineHeight": "26px", "fontWeight": "700"}]
              }
            },
          },
        }
    </script>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-surface-bg font-body-md text-on-surface flex flex-col min-h-screen">
<!-- Top App Bar -->
<header class="fixed top-0 w-full z-50 bg-surface dark:bg-on-surface border-b-4 border-surface-container-high dark:border-surface-dim flex justify-between items-center px-margin-mobile h-16">
<button class="material-symbols-outlined text-primary text-2xl active:translate-y-1 transition-transform" data-icon="close">close</button>
<h1 class="font-headline-md-mobile text-headline-md-mobile dark:text-surface uppercase tracking-tight">NEW QUEST</h1>
<div class="w-10 h-10 rounded-full border-2 border-primary overflow-hidden active:translate-y-1 transition-transform">
<img class="w-full h-full object-cover" data-alt="A vibrant digital avatar portrait of a friendly character wearing a golden celebratory crown, set against a bright green background. The style is playful and chunky with thick outlines, consistent with a high-energy gamified task management application." src="https://lh3.googleusercontent.com/aida-public/AB6AXuAAcPH8KsDjc80EHZXxfve3z1KCmHRKxbYDvvIWLNcPQWckU71u_7Nv8pGRqfGdi8yrPI0QjgDNDIpMZ44UrUr8qbRjdBlJSflltrW6lNLto9VxscxEInwzfCJUFjYogG-hfXfmm4TJGLBxOWS4z0f1Q32MptONBYsEGlFyD7p9_sCuocJ5VPmeib8Ov5btE9btVZejSJjD1WJrlpKammtOKRhjVbB5wGmO0xzZuTfW13DYelg5FSLeaKLFxHIYjquBiirwqhZGLJQL"/>
</div>
</header>
<!-- Main Content Area -->
<main class="flex-grow pt-24 pb-32 px-margin-mobile max-w-lg mx-auto w-full">
<form class="space-y-stack-lg">
<!-- Activity Name Input -->
<div class="space-y-stack-sm">
<label class="font-label-bold text-label-bold text-on-surface-variant uppercase ml-1">Quest Name</label>
<div class="relative group">
<input class="w-full h-16 px-6 bg-surface-card border-2 border-on-surface-variant rounded-xl font-headline-md text-headline-md placeholder:text-outline-variant focus:border-primary focus:ring-0 outline-none transition-all input-chunky-focus" placeholder="Ex: Slay the Dragon Gym" type="text"/>
<div class="absolute inset-0 pointer-events-none rounded-xl border-b-4 border-r-2 border-on-surface-variant/20 -z-10 translate-y-1"></div>
</div>
</div>
<!-- Category Selection Chips -->
<div class="space-y-stack-sm">
<label class="font-label-bold text-label-bold text-on-surface-variant uppercase ml-1">Category</label>
<div class="flex flex-wrap gap-3">
<!-- Category: Health -->
<button class="chip-active flex items-center gap-2 px-4 py-2 bg-surface-card border-2 border-primary rounded-full font-label-bold text-label-bold text-primary shadow-[0_4px_0_0_#1e5000] active:translate-y-[4px] active:shadow-none transition-all" onclick="selectChip(this, 'primary')" type="button">
<span class="material-symbols-outlined" data-icon="favorite">favorite</span>
                        HEALTH
                    </button>
<!-- Category: Work -->
<button class="flex items-center gap-2 px-4 py-2 bg-surface-card border-2 border-outline rounded-full font-label-bold text-label-bold text-on-surface-variant shadow-[0_4px_0_0_rgba(0,0,0,0.1)] active:translate-y-[4px] active:shadow-none transition-all" onclick="selectChip(this, 'tertiary')" type="button">
<span class="material-symbols-outlined" data-icon="work">work</span>
                        WORK
                    </button>
<!-- Category: Social -->
<button class="flex items-center gap-2 px-4 py-2 bg-surface-card border-2 border-outline rounded-full font-label-bold text-label-bold text-on-surface-variant shadow-[0_4px_0_0_rgba(0,0,0,0.1)] active:translate-y-[4px] active:shadow-none transition-all" onclick="selectChip(this, 'secondary-container')" type="button">
<span class="material-symbols-outlined" data-icon="group">group</span>
                        SOCIAL
                    </button>
<!-- Category: Personal -->
<button class="flex items-center gap-2 px-4 py-2 bg-surface-card border-2 border-outline rounded-full font-label-bold text-label-bold text-on-surface-variant shadow-[0_4px_0_0_rgba(0,0,0,0.1)] active:translate-y-[4px] active:shadow-none transition-all" onclick="selectChip(this, 'celebratory-purple')" type="button">
<span class="material-symbols-outlined" data-icon="auto_awesome">auto_awesome</span>
                        MIND
                    </button>
</div>
</div>
<!-- Bento Layout for Time and Difficulty -->
<div class="grid grid-cols-2 gap-stack-md">
<!-- Time Picker -->
<div class="space-y-stack-sm">
<label class="font-label-bold text-label-bold text-on-surface-variant uppercase ml-1">Reminder</label>
<div class="relative bg-surface-card border-2 border-on-surface-variant rounded-xl h-16 flex items-center px-4 overflow-hidden">
<span class="material-symbols-outlined text-on-surface-variant mr-3" data-icon="schedule">schedule</span>
<input class="w-full bg-transparent border-none font-label-bold text-label-bold focus:ring-0 cursor-pointer" type="time" value="08:00"/>
<div class="absolute inset-0 pointer-events-none rounded-xl border-b-4 border-on-surface-variant/10 -z-10 translate-y-1"></div>
</div>
</div>
<!-- XP/Difficulty Selector -->
<div class="space-y-stack-sm">
<label class="font-label-bold text-label-bold text-on-surface-variant uppercase ml-1">XP Reward</label>
<div class="relative bg-surface-card border-2 border-on-surface-variant rounded-xl h-16 flex items-center justify-center gap-2">
<span class="material-symbols-outlined text-secondary-container" data-icon="stars" style="font-variation-settings: 'FILL' 1;">stars</span>
<span class="font-headline-md text-headline-md">150</span>
<div class="absolute inset-0 pointer-events-none rounded-xl border-b-4 border-on-surface-variant/10 -z-10 translate-y-1"></div>
</div>
</div>
</div>
<!-- Notes Section -->
<div class="space-y-stack-sm">
<label class="font-label-bold text-label-bold text-on-surface-variant uppercase ml-1">Quest Log Notes</label>
<div class="relative">
<textarea class="w-full p-4 bg-surface-card border-2 border-on-surface-variant rounded-xl font-body-md text-body-md placeholder:text-outline-variant focus:border-primary focus:ring-0 outline-none transition-all" placeholder="Add some tactical advice for your future self..." rows="3"></textarea>
<div class="absolute inset-0 pointer-events-none rounded-xl border-b-4 border-on-surface-variant/20 -z-10 translate-y-1"></div>
</div>
</div>
<!-- Illustration Asset -->
<div class="relative h-48 w-full bg-primary-container/20 rounded-3xl border-2 border-dashed border-primary flex items-center justify-center overflow-hidden">
<div class="text-center p-6">
<span class="material-symbols-outlined text-5xl text-primary mb-2 block" data-icon="fortress">compress</span>
<p class="font-label-bold text-label-bold text-primary px-12">Complete this quest to expand your territory!</p>
</div>
<!-- Background decorative shapes -->
<div class="absolute -top-10 -right-10 w-32 h-32 bg-primary/10 rounded-full blur-2xl"></div>
<div class="absolute -bottom-10 -left-10 w-32 h-32 bg-secondary-container/10 rounded-full blur-2xl"></div>
</div>
</form>
</main>
<!-- Bottom Action Area -->
<footer class="fixed bottom-0 w-full z-50 bg-surface dark:bg-inverse-surface border-t-4 border-surface-container-high dark:border-surface-dim px-margin-mobile pt-4 pb-8">
<button class="w-full h-16 bg-primary-container text-on-primary-container font-headline-md text-headline-md rounded-2xl border-2 border-primary chunky-shadow shadow-primary active:translate-y-[6px] active:shadow-none transition-all flex items-center justify-center gap-3">
<span class="material-symbols-outlined" data-icon="add_circle" style="font-variation-settings: 'FILL' 1;">add_circle</span>
            CREATE ACTIVITY
        </button>
</footer>
<script>
        function selectChip(element, colorKey) {
            // Reset all chips in the same group
            const chips = element.parentElement.querySelectorAll('button');
            chips.forEach(chip => {
                chip.classList.remove('border-primary', 'text-primary', 'shadow-[0_4px_0_0_#1e5000]');
                chip.classList.add('border-outline', 'text-on-surface-variant', 'shadow-[0_4px_0_0_rgba(0,0,0,0.1)]');
                const icon = chip.querySelector('.material-symbols-outlined');
                if (icon) icon.style.fontVariationSettings = "'FILL' 0";
            });

            // Set active styles for clicked chip
            element.classList.remove('border-outline', 'text-on-surface-variant', 'shadow-[0_4px_0_0_rgba(0,0,0,0.1)]');
            
            // Map color keys to actual tailwind classes for the active state
            const colorMap = {
                'primary': { border: 'border-primary', text: 'text-primary', shadow: 'shadow-[0_4px_0_0_#1e5000]' },
                'tertiary': { border: 'border-tertiary', text: 'text-tertiary', shadow: 'shadow-[0_4px_0_0_#004a6b]' },
                'secondary-container': { border: 'border-secondary-container', text: 'text-on-secondary-container', shadow: 'shadow-[0_4px_0_0_#633700]' },
                'celebratory-purple': { border: 'border-celebratory-purple', text: 'text-celebratory-purple', shadow: 'shadow-[0_4px_0_0_#8e44ad]' }
            };

            const styles = colorMap[colorKey];
            element.classList.add(styles.border, styles.text, styles.shadow);
            const icon = element.querySelector('.material-symbols-outlined');
            if (icon) icon.style.fontVariationSettings = "'FILL' 1";
        }
    </script>
</body></html>

<!-- Weekly Planner -->
<!DOCTYPE html>

<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Quest Log - Weekly Planner</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;700&family=Plus+Jakarta+Sans:wght@700;800&family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@100..900&family=Plus+Jakarta+Sans:wght@100..900&display=swap" rel="stylesheet"/>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }
        .chunky-shadow {
            box-shadow: 0 4px 0 0 var(--tw-shadow-color);
        }
        .chunky-shadow-active {
            box-shadow: 0 0px 0 0 var(--tw-shadow-color);
            transform: translateY(4px);
        }
        .hide-scrollbar::-webkit-scrollbar {
            display: none;
        }
        .hide-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
    </style>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "primary-fixed-dim": "#6be026",
                        "background": "#fbf9f9",
                        "surface-container-low": "#f5f3f3",
                        "inverse-surface": "#303031",
                        "surface": "#fbf9f9",
                        "on-background": "#1b1c1c",
                        "outline-variant": "#becbb1",
                        "on-surface-variant": "#3f4a36",
                        "surface-container-lowest": "#ffffff",
                        "on-tertiary-fixed-variant": "#004c6e",
                        "secondary-fixed-dim": "#ffb872",
                        "tertiary-fixed-dim": "#88ceff",
                        "primary-container": "#58cc02",
                        "surface-dim": "#dbdad9",
                        "on-primary-fixed-variant": "#1f5100",
                        "on-error": "#ffffff",
                        "secondary-fixed": "#ffdcbf",
                        "secondary-container": "#fd9500",
                        "on-secondary-fixed-variant": "#6a3b00",
                        "on-tertiary": "#ffffff",
                        "surface-container-highest": "#e3e2e2",
                        "on-surface": "#1b1c1c",
                        "on-error-container": "#93000a",
                        "tertiary-fixed": "#c8e6ff",
                        "secondary": "#8c5000",
                        "primary-fixed": "#87fe45",
                        "celebratory-purple": "#CE82FF",
                        "on-primary-fixed": "#082100",
                        "on-primary-container": "#1e5000",
                        "on-secondary-fixed": "#2d1600",
                        "surface-variant": "#e3e2e2",
                        "error-container": "#ffdad6",
                        "surface-container-high": "#e9e8e7",
                        "on-tertiary-fixed": "#001e2e",
                        "border-depth": "rgba(0, 0, 0, 0.2)",
                        "error-red": "#FF4B4B",
                        "tertiary": "#006590",
                        "surface-card": "#FFFFFF",
                        "surface-bg": "#F7F7F7",
                        "inverse-on-surface": "#f2f0f0",
                        "inverse-primary": "#6be026",
                        "primary": "#2b6c00",
                        "on-secondary-container": "#633700",
                        "outline": "#6f7b64",
                        "surface-bright": "#fbf9f9",
                        "surface-container": "#efeded",
                        "surface-tint": "#2b6c00",
                        "on-secondary": "#ffffff",
                        "error": "#ba1a1a",
                        "tertiary-container": "#4abdff",
                        "on-tertiary-container": "#004a6b",
                        "on-primary": "#ffffff"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "margin-mobile": "16px",
                        "margin-desktop": "32px",
                        "gutter": "12px",
                        "stack-md": "16px",
                        "base-unit": "4px",
                        "stack-sm": "8px",
                        "stack-lg": "24px"
                    },
                    "fontFamily": {
                        "label-sm": ["Be Vietnam Pro"],
                        "headline-lg-mobile": ["Plus Jakarta Sans"],
                        "label-bold": ["Be Vietnam Pro"],
                        "headline-lg": ["Plus Jakarta Sans"],
                        "display-hero": ["Plus Jakarta Sans"],
                        "body-lg": ["Be Vietnam Pro"],
                        "headline-md": ["Plus Jakarta Sans"],
                        "body-md": ["Be Vietnam Pro"]
                    },
                    "fontSize": {
                        "label-sm": ["13px", {"lineHeight": "18px", "fontWeight": "400"}],
                        "headline-lg-mobile": ["24px", {"lineHeight": "30px", "fontWeight": "800"}],
                        "label-bold": ["14px", {"lineHeight": "20px", "letterSpacing": "0.05em", "fontWeight": "700"}],
                        "headline-lg": ["28px", {"lineHeight": "34px", "fontWeight": "800"}],
                        "display-hero": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "800"}],
                        "body-lg": ["18px", {"lineHeight": "26px", "fontWeight": "500"}],
                        "headline-md": ["20px", {"lineHeight": "26px", "fontWeight": "700"}],
                        "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "500"}]
                    }
                },
            },
        }
    </script>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-background text-on-background font-body-md min-h-screen pb-24">
<!-- TopAppBar -->
<header class="fixed top-0 w-full z-50 bg-surface dark:bg-on-surface border-b-4 border-surface-container-high dark:border-surface-dim flex justify-between items-center px-margin-mobile h-16">
<div class="flex items-center gap-2">
<div class="w-10 h-10 rounded-full border-2 border-primary-container overflow-hidden bg-surface-container">
<img class="w-full h-full object-cover" data-alt="A cheerful 3D avatar profile of a young adventurer wearing a golden celebratory crown, rendered in a high-quality stylized claymation look similar to modern gaming apps. The background is a soft pastel green, creating a vibrant and encouraging atmosphere. The lighting is bright and cheerful, highlighting the tactile textures of the character's clothing and crown." src="https://lh3.googleusercontent.com/aida-public/AB6AXuAVltDJz7n8pZfq5_EorzU4rNxjDtuZbwdVcNztIHnmRIFv-4pPlE-LRECtnqLaQCWP77IXk_llOFBi0I_wbXMWxO61gHaR4xwFQVV3IChEYWMMqjItMEgvSzGMUOOxMKM03GWuj78UKgeJTJkfHH63RkdgUTtLe8gblKkOXlRq_xdSJvSunFN2DsFJ56Qwd86VdM2b18pCOCb4JIfmYHeMW8P65iBE8co7TTumDJzhPAweD_etx7Ub8OcciyeMBg_aErL5fs7rnct9"/>
</div>
</div>
<h1 class="font-headline-lg-mobile text-headline-lg-mobile text-primary tracking-tighter uppercase">QUEST LOG</h1>
<button class="text-primary dark:text-primary-fixed hover:opacity-80 active:translate-y-1 transition-transform">
<span class="material-symbols-outlined text-3xl">local_fire_department</span>
</button>
</header>
<main class="pt-20 px-margin-mobile">
<!-- Week Selector Horizontal Scroll -->
<section class="mb-stack-lg">
<div class="flex items-center justify-between mb-stack-sm">
<h2 class="font-headline-md text-headline-md">September</h2>
<span class="font-label-bold text-label-bold text-outline uppercase tracking-widest">Week 38</span>
</div>
<div class="flex gap-3 overflow-x-auto pb-4 hide-scrollbar">
<!-- Day Card (Mon) -->
<div class="flex-shrink-0 w-20 p-3 bg-surface-card border-2 border-surface-container-highest rounded-xl chunky-shadow shadow-surface-container-highest text-center transition-all cursor-pointer hover:bg-surface-container-low">
<span class="block font-label-bold text-label-bold text-outline">MON</span>
<span class="block font-headline-md text-headline-md mb-2">18</span>
<div class="w-full h-2 bg-surface-container rounded-full overflow-hidden">
<div class="w-[80%] h-full bg-primary-container"></div>
</div>
</div>
<!-- Day Card (Tue - Active Today) -->
<div class="flex-shrink-0 w-20 p-3 bg-primary-container border-2 border-primary text-on-primary-container rounded-xl chunky-shadow shadow-primary text-center active:translate-y-1 active:shadow-none">
<span class="block font-label-bold text-label-bold opacity-80">TUE</span>
<span class="block font-headline-md text-headline-md mb-2">19</span>
<div class="w-full h-2 bg-white/30 rounded-full overflow-hidden">
<div class="w-[40%] h-full bg-white"></div>
</div>
</div>
<!-- Day Card (Wed) -->
<div class="flex-shrink-0 w-20 p-3 bg-surface-card border-2 border-surface-container-highest rounded-xl chunky-shadow shadow-surface-container-highest text-center transition-all cursor-pointer">
<span class="block font-label-bold text-label-bold text-outline">WED</span>
<span class="block font-headline-md text-headline-md mb-2">20</span>
<div class="w-full h-2 bg-surface-container rounded-full overflow-hidden">
<div class="w-[0%] h-full bg-primary-container"></div>
</div>
</div>
<!-- Day Card (Thu) -->
<div class="flex-shrink-0 w-20 p-3 bg-surface-card border-2 border-surface-container-highest rounded-xl chunky-shadow shadow-surface-container-highest text-center transition-all cursor-pointer">
<span class="block font-label-bold text-label-bold text-outline">THU</span>
<span class="block font-headline-md text-headline-md mb-2">21</span>
<div class="w-full h-2 bg-surface-container rounded-full overflow-hidden">
<div class="w-[20%] h-full bg-primary-container"></div>
</div>
</div>
<!-- Day Card (Fri) -->
<div class="flex-shrink-0 w-20 p-3 bg-surface-card border-2 border-surface-container-highest rounded-xl chunky-shadow shadow-surface-container-highest text-center transition-all cursor-pointer">
<span class="block font-label-bold text-label-bold text-outline">FRI</span>
<span class="block font-headline-md text-headline-md mb-2">22</span>
<div class="w-full h-2 bg-surface-container rounded-full overflow-hidden">
<div class="w-[95%] h-full bg-primary-container"></div>
</div>
</div>
</div>
</section>
<!-- Plan Your Week Section (Bento Grid Style) -->
<section class="mb-stack-lg">
<h3 class="font-headline-md text-headline-md mb-stack-md">Your Weekly Quests</h3>
<div class="grid grid-cols-2 gap-4">
<!-- Large Task Card -->
<div class="col-span-2 p-5 bg-surface-card border-2 border-outline-variant rounded-2xl chunky-shadow shadow-outline-variant">
<div class="flex items-start justify-between mb-4">
<div>
<span class="bg-secondary-container text-on-secondary-fixed font-label-bold text-label-sm px-3 py-1 rounded-full uppercase">Current Goal</span>
<h4 class="font-headline-md text-headline-md mt-2">Finish Language Module</h4>
</div>
<div class="w-14 h-14 bg-secondary-fixed rounded-xl flex items-center justify-center">
<span class="material-symbols-outlined text-secondary text-3xl" style="font-variation-settings: 'FILL' 1;">translate</span>
</div>
</div>
<div class="flex items-center gap-3 mb-2">
<div class="flex-1 h-4 bg-surface-container rounded-full overflow-hidden">
<div class="w-[65%] h-full bg-secondary-container"></div>
</div>
<span class="font-label-bold text-label-bold text-secondary">65%</span>
</div>
<p class="font-body-md text-on-surface-variant">3 sessions left this week to reach your goal!</p>
</div>
<!-- Small Add Card -->
<div class="p-4 bg-tertiary-container/10 border-2 border-tertiary-container border-dashed rounded-2xl flex flex-col items-center justify-center text-center cursor-pointer hover:bg-tertiary-container/20 transition-colors">
<div class="w-10 h-10 bg-tertiary-container rounded-full flex items-center justify-center mb-2 shadow-sm">
<span class="material-symbols-outlined text-white">add</span>
</div>
<span class="font-label-bold text-label-bold text-tertiary">Quick Add Task</span>
</div>
<!-- Daily Streak Mini Card -->
<div class="p-4 bg-surface-card border-2 border-outline-variant rounded-2xl chunky-shadow shadow-outline-variant flex flex-col justify-between">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-error-red" style="font-variation-settings: 'FILL' 1;">bolt</span>
<span class="font-label-bold text-label-sm uppercase">Active Streak</span>
</div>
<div class="mt-2">
<span class="font-display-hero text-display-hero text-error-red">12</span>
<span class="font-label-bold text-label-bold text-outline">DAYS</span>
</div>
</div>
</div>
</section>
<!-- Activities Queue (Drag & Drop Intent) -->
<section class="mb-12">
<div class="flex items-center justify-between mb-stack-md">
<h3 class="font-headline-md text-headline-md">Suggested Activities</h3>
<button class="text-primary font-label-bold text-label-bold">SEE ALL</button>
</div>
<div class="space-y-3">
<!-- Activity Item -->
<div class="flex items-center gap-4 p-4 bg-surface-card border-2 border-outline-variant rounded-2xl chunky-shadow shadow-outline-variant hover:scale-[1.01] transition-transform active:translate-y-1 active:shadow-none cursor-grab">
<div class="w-12 h-12 rounded-xl bg-celebratory-purple/20 flex items-center justify-center">
<span class="material-symbols-outlined text-celebratory-purple text-2xl" style="font-variation-settings: 'FILL' 1;">fitness_center</span>
</div>
<div class="flex-1">
<h5 class="font-label-bold text-label-bold">Morning Gym Session</h5>
<p class="text-label-sm text-outline">45 mins • Health</p>
</div>
<button class="w-10 h-10 rounded-full border-2 border-primary text-primary flex items-center justify-center hover:bg-primary-container hover:text-white transition-colors">
<span class="material-symbols-outlined">calendar_add_on</span>
</button>
</div>
<!-- Activity Item -->
<div class="flex items-center gap-4 p-4 bg-surface-card border-2 border-outline-variant rounded-2xl chunky-shadow shadow-outline-variant hover:scale-[1.01] transition-transform active:translate-y-1 active:shadow-none cursor-grab">
<div class="w-12 h-12 rounded-xl bg-tertiary-container/20 flex items-center justify-center">
<span class="material-symbols-outlined text-tertiary-container text-2xl" style="font-variation-settings: 'FILL' 1;">book</span>
</div>
<div class="flex-1">
<h5 class="font-label-bold text-label-bold">Read 10 Pages</h5>
<p class="text-label-sm text-outline">20 mins • Learning</p>
</div>
<button class="w-10 h-10 rounded-full border-2 border-primary text-primary flex items-center justify-center hover:bg-primary-container hover:text-white transition-colors">
<span class="material-symbols-outlined">calendar_add_on</span>
</button>
</div>
<!-- Activity Item -->
<div class="flex items-center gap-4 p-4 bg-surface-card border-2 border-outline-variant rounded-2xl chunky-shadow shadow-outline-variant hover:scale-[1.01] transition-transform active:translate-y-1 active:shadow-none cursor-grab">
<div class="w-12 h-12 rounded-xl bg-secondary-container/20 flex items-center justify-center">
<span class="material-symbols-outlined text-secondary-container text-2xl" style="font-variation-settings: 'FILL' 1;">mediation</span>
</div>
<div class="flex-1">
<h5 class="font-label-bold text-label-bold">Daily Mindfulness</h5>
<p class="text-label-sm text-outline">10 mins • Spirit</p>
</div>
<button class="w-10 h-10 rounded-full border-2 border-primary text-primary flex items-center justify-center hover:bg-primary-container hover:text-white transition-colors">
<span class="material-symbols-outlined">calendar_add_on</span>
</button>
</div>
</div>
</section>
</main>
<!-- FAB: Contextual to Planner -->
<button class="fixed right-6 bottom-24 w-16 h-16 bg-primary-container text-white rounded-2xl chunky-shadow shadow-primary flex items-center justify-center z-40 active:translate-y-1 active:shadow-none transition-all">
<span class="material-symbols-outlined text-4xl">edit_calendar</span>
</button>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 w-full z-50 bg-surface dark:bg-inverse-surface border-t-4 border-surface-container-high dark:border-surface-dim flex justify-around items-end pb-4 px-2 rounded-t-xl">
<!-- Today Tab -->
<a class="flex flex-col items-center justify-center text-outline dark:text-outline-variant pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined text-2xl">bolt</span>
<span class="font-label-bold text-label-bold">Today</span>
</a>
<!-- Planner Tab (Active) -->
<a class="flex flex-col items-center justify-center text-primary dark:text-primary-fixed border-t-4 border-primary dark:border-primary-fixed pt-2 active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined text-2xl" style="font-variation-settings: 'FILL' 1;">calendar_today</span>
<span class="font-label-bold text-label-bold">Planner</span>
</a>
<!-- Stats Tab -->
<a class="flex flex-col items-center justify-center text-outline dark:text-outline-variant pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined text-2xl">leaderboard</span>
<span class="font-label-bold text-label-bold">Stats</span>
</a>
<!-- Friends Tab -->
<a class="flex flex-col items-center justify-center text-outline dark:text-outline-variant pt-3 hover:text-primary-container active:scale-95 transition-all" href="#">
<span class="material-symbols-outlined text-2xl">group</span>
<span class="font-label-bold text-label-bold">Friends</span>
</a>
</nav>
<script>
        // Micro-interaction for chunky buttons
        document.querySelectorAll('.chunky-shadow').forEach(btn => {
            btn.addEventListener('mousedown', () => {
                btn.style.transform = 'translateY(4px)';
                btn.style.boxShadow = '0 0px 0 0 transparent';
            });
            btn.addEventListener('mouseup', () => {
                btn.style.transform = 'translateY(0)';
                // Resetting shadow depends on original class, simpler to just let CSS active handle it if possible
                // but this script adds manual feel for non-button elements
            });
            btn.addEventListener('mouseleave', () => {
                btn.style.transform = 'translateY(0)';
            });
        });

        // Simple observer for potential animation triggers
        const observerOptions = {
            threshold: 0.1
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('opacity-100');
                    entry.target.classList.remove('opacity-0');
                }
            });
        }, observerOptions);

        document.querySelectorAll('section').forEach(section => {
            section.classList.add('transition-opacity', 'duration-500');
        });
    </script>
</body></html>

<!-- Today's Quests -->
<!DOCTYPE html>

<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Quest Log - Today</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@700;800&amp;family=Be+Vietnam+Pro:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<style>
        .chunky-shadow {
            box-shadow: 0 4px 0 0 var(--tw-shadow-color);
        }
        .chunky-shadow-active {
            box-shadow: 0 0px 0 0 var(--tw-shadow-color);
            transform: translateY(4px);
        }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .filled-icon {
            font-variation-settings: 'FILL' 1;
        }
    </style>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "outline-variant": "#becbb1",
                        "primary": "#2b6c00",
                        "on-tertiary-container": "#004a6b",
                        "surface-bg": "#F7F7F7",
                        "secondary-fixed-dim": "#ffb872",
                        "inverse-on-surface": "#f2f0f0",
                        "on-secondary-fixed-variant": "#6a3b00",
                        "on-surface": "#1b1c1c",
                        "error-red": "#FF4B4B",
                        "on-tertiary-fixed-variant": "#004c6e",
                        "on-primary": "#ffffff",
                        "secondary-container": "#fd9500",
                        "surface": "#fbf9f9",
                        "surface-container-low": "#f5f3f3",
                        "on-error": "#ffffff",
                        "surface-bright": "#fbf9f9",
                        "surface-container-high": "#e9e8e7",
                        "error": "#ba1a1a",
                        "on-tertiary-fixed": "#001e2e",
                        "secondary": "#8c5000",
                        "primary-fixed-dim": "#6be026",
                        "tertiary-fixed-dim": "#88ceff",
                        "outline": "#6f7b64",
                        "tertiary-container": "#4abdff",
                        "celebratory-purple": "#CE82FF",
                        "border-depth": "rgba(0, 0, 0, 0.2)",
                        "inverse-primary": "#6be026",
                        "on-primary-container": "#1e5000",
                        "tertiary": "#006590",
                        "surface-container": "#efeded",
                        "on-primary-fixed-variant": "#1f5100",
                        "surface-container-lowest": "#ffffff",
                        "background": "#fbf9f9",
                        "on-primary-fixed": "#082100",
                        "surface-tint": "#2b6c00",
                        "secondary-fixed": "#ffdcbf",
                        "surface-card": "#FFFFFF",
                        "error-container": "#ffdad6",
                        "primary-fixed": "#87fe45",
                        "on-error-container": "#93000a",
                        "on-secondary-fixed": "#2d1600",
                        "surface-dim": "#dbdad9",
                        "on-secondary": "#ffffff",
                        "surface-variant": "#e3e2e2",
                        "on-surface-variant": "#3f4a36",
                        "on-tertiary": "#ffffff",
                        "primary-container": "#58cc02",
                        "surface-container-highest": "#e3e2e2",
                        "on-secondary-container": "#633700",
                        "tertiary-fixed": "#c8e6ff",
                        "inverse-surface": "#303031",
                        "on-background": "#1b1c1c"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "stack-sm": "8px",
                        "gutter": "12px",
                        "margin-mobile": "16px",
                        "margin-desktop": "32px",
                        "stack-md": "16px",
                        "base-unit": "4px",
                        "stack-lg": "24px"
                    },
                    "fontFamily": {
                        "headline-lg-mobile": ["Plus Jakarta Sans"],
                        "label-bold": ["Be Vietnam Pro"],
                        "display-hero": ["Plus Jakarta Sans"],
                        "body-md": ["Be Vietnam Pro"],
                        "body-lg": ["Be Vietnam Pro"],
                        "label-sm": ["Be Vietnam Pro"],
                        "headline-lg": ["Plus Jakarta Sans"],
                        "headline-md": ["Plus Jakarta Sans"]
                    },
                    "fontSize": {
                        "headline-lg-mobile": ["24px", {"lineHeight": "30px", "fontWeight": "800"}],
                        "label-bold": ["14px", {"lineHeight": "20px", "letterSpacing": "0.05em", "fontWeight": "700"}],
                        "display-hero": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "800"}],
                        "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "500"}],
                        "body-lg": ["18px", {"lineHeight": "26px", "fontWeight": "500"}],
                        "label-sm": ["13px", {"lineHeight": "18px", "fontWeight": "400"}],
                        "headline-lg": ["28px", {"lineHeight": "34px", "fontWeight": "800"}],
                        "headline-md": ["20px", {"lineHeight": "26px", "fontWeight": "700"}]
                    }
                },
            },
        }
    </script>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-surface-bg text-on-surface font-body-md min-h-screen pb-32">
<!-- TopAppBar -->
<header class="fixed top-0 w-full z-50 bg-surface dark:bg-on-surface border-b-4 border-surface-container-high dark:border-surface-dim flex justify-between items-center px-margin-mobile h-16">
<div class="flex items-center gap-3">
<div class="w-10 h-10 rounded-full border-2 border-primary overflow-hidden shadow-[0_2px_0_0_rgba(0,0,0,0.2)]">
<img class="w-full h-full object-cover" data-alt="A vibrant digital illustration of a playful avatar wearing a golden celebratory crown. The character has a cheerful expression, set against a bright, clean background with high-energy colors like primary green and secondary orange. The style is 3D-inspired and tactile, consistent with a gamified task management application." src="https://lh3.googleusercontent.com/aida-public/AB6AXuAzmw-QUyxQTb4RL12q5P8OS59mZhDjJZf__sZNx9rjElzqcIhgShd3YN16c7Yuc2qc36vnGyjI5c_7ar5SPgvMHkeViOTs0oO9_GIOpFF5hseHBE7o_ckn4nKkuRFZmVNMthwRkYxpQpuJhVSHsJuA8_nPFsj3B0PSFZyq1g8Hz-Phk2QAameXE0ivq4rDUnrA59-KvFhqdkM1hMv3fJNnIK_Zi624RQYdjOf-TD9vxqN8BN94Ts3y4E4OLVmeWgwqWoWfgQp4Gey7"/>
</div>
<h1 class="font-headline-lg-mobile text-headline-lg-mobile text-primary tracking-tighter uppercase">QUEST LOG</h1>
</div>
<button class="active:translate-y-1 transition-transform hover:opacity-80">
<span class="material-symbols-outlined text-primary text-3xl" style="font-variation-settings: 'FILL' 1;">local_fire_department</span>
</button>
</header>
<main class="mt-20 px-margin-mobile">
<!-- Daily Progress Section -->
<section class="mb-stack-lg">
<div class="flex justify-between items-end mb-2">
<h2 class="font-headline-md text-headline-md text-on-surface">Daily Quest</h2>
<span class="font-label-bold text-label-bold text-primary">60% Complete</span>
</div>
<div class="h-6 w-full bg-surface-container-high rounded-full border-2 border-outline-variant relative overflow-hidden">
<div class="h-full bg-primary-container border-r-2 border-primary" id="progress-fill" style="width: 60%; transition: width 0.5s ease-out;"></div>
</div>
</section>
<!-- Streak Highlight Bento -->
<section class="grid grid-cols-2 gap-stack-md mb-stack-lg">
<div class="bg-secondary-fixed border-2 border-secondary p-stack-md rounded-xl shadow-[0_4px_0_0_#8c5000] flex flex-col items-center justify-center text-center">
<span class="material-symbols-outlined text-secondary text-5xl mb-1 filled-icon">local_fire_department</span>
<p class="font-display-hero text-display-hero text-secondary leading-none">12</p>
<p class="font-label-bold text-label-bold text-on-secondary-fixed-variant uppercase">Day Streak</p>
</div>
<div class="bg-tertiary-fixed border-2 border-tertiary p-stack-md rounded-xl shadow-[0_4px_0_0_#006590] flex flex-col items-center justify-center text-center">
<span class="material-symbols-outlined text-tertiary text-5xl mb-1 filled-icon">workspace_premium</span>
<p class="font-display-hero text-display-hero text-tertiary leading-none">4</p>
<p class="font-label-bold text-label-bold text-on-tertiary-fixed-variant uppercase">Badges</p>
</div>
</section>
<!-- Activity Checklist -->
<section class="space-y-stack-md">
<h3 class="font-label-bold text-label-bold text-outline uppercase tracking-widest px-1">Today's Missions</h3>
<!-- Task Card 1 (Completed) -->
<div class="activity-card group bg-surface-card border-2 border-outline-variant p-4 rounded-xl shadow-[0_4px_0_0_#becbb1] active:translate-y-[4px] active:shadow-none transition-all cursor-pointer flex items-center gap-4">
<div class="flex-shrink-0 w-12 h-12 rounded-lg border-2 border-primary bg-primary-container flex items-center justify-center">
<span class="material-symbols-outlined text-on-primary-container text-3xl filled-icon">check_circle</span>
</div>
<div class="flex-grow">
<div class="flex justify-between items-start">
<h4 class="font-headline-md text-headline-md leading-tight line-through opacity-50">Morning Run</h4>
<span class="bg-tertiary-container/20 text-on-tertiary-container text-[10px] font-bold px-2 py-0.5 rounded border border-tertiary-container uppercase">Fitness</span>
</div>
<p class="font-label-sm text-label-sm text-outline">07:00 AM • 30 mins</p>
</div>
</div>
<!-- Task Card 2 (Active) -->
<div class="activity-card group bg-surface-card border-2 border-primary p-4 rounded-xl shadow-[0_4px_0_0_#2b6c00] active:translate-y-[4px] active:shadow-none transition-all cursor-pointer flex items-center gap-4" onclick="toggleTask(this)">
<div class="checkbox-container flex-shrink-0 w-12 h-12 rounded-lg border-2 border-outline-variant bg-surface-container flex items-center justify-center transition-colors group-hover:border-primary">
<span class="material-symbols-outlined text-outline text-3xl opacity-0 transition-opacity">check</span>
</div>
<div class="flex-grow">
<div class="flex justify-between items-start">
<h4 class="font-headline-md text-headline-md leading-tight">Deep Work Session</h4>
<span class="bg-secondary-container/20 text-on-secondary-container text-[10px] font-bold px-2 py-0.5 rounded border border-secondary-container uppercase">Focus</span>
</div>
<p class="font-label-sm text-label-sm text-outline">09:00 AM • 90 mins</p>
</div>
<span class="material-symbols-outlined text-secondary filled-icon">local_fire_department</span>
</div>
<!-- Task Card 3 -->
<div class="activity-card group bg-surface-card border-2 border-outline-variant p-4 rounded-xl shadow-[0_4px_0_0_#becbb1] active:translate-y-[4px] active:shadow-none transition-all cursor-pointer flex items-center gap-4" onclick="toggleTask(this)">
<div class="checkbox-container flex-shrink-0 w-12 h-12 rounded-lg border-2 border-outline-variant bg-surface-container flex items-center justify-center transition-colors group-hover:border-primary">
<span class="material-symbols-outlined text-outline text-3xl opacity-0 transition-opacity">check</span>
</div>
<div class="flex-grow">
<div class="flex justify-between items-start">
<h4 class="font-headline-md text-headline-md leading-tight">Learn Spanish</h4>
<span class="bg-celebratory-purple/20 text-on-surface text-[10px] font-bold px-2 py-0.5 rounded border border-celebratory-purple uppercase">Skill</span>
</div>
<p class="font-label-sm text-label-sm text-outline">01:00 PM • 15 mins</p>
</div>
</div>
<!-- Task Card 4 -->
<div class="activity-card group bg-surface-card border-2 border-outline-variant p-4 rounded-xl shadow-[0_4px_0_0_#becbb1] active:translate-y-[4px] active:shadow-none transition-all cursor-pointer flex items-center gap-4" onclick="toggleTask(this)">
<div class="checkbox-container flex-shrink-0 w-12 h-12 rounded-lg border-2 border-outline-variant bg-surface-container flex items-center justify-center transition-colors group-hover:border-primary">
<span class="material-symbols-outlined text-outline text-3xl opacity-0 transition-opacity">check</span>
</div>
<div class="flex-grow">
<div class="flex justify-between items-start">
<h4 class="font-headline-md text-headline-md leading-tight">Read 10 Pages</h4>
<span class="bg-tertiary-container/20 text-on-tertiary-container text-[10px] font-bold px-2 py-0.5 rounded border border-tertiary-container uppercase">Habit</span>
</div>
<p class="font-label-sm text-label-sm text-outline">08:00 PM • 20 mins</p>
</div>
</div>
</section>
<!-- Empty State Suggestion Card -->
<div class="mt-stack-lg p-6 rounded-2xl bg-primary-fixed-dim/20 border-2 border-dashed border-primary flex flex-col items-center text-center gap-4">
<span class="material-symbols-outlined text-primary text-5xl">add_circle</span>
<div>
<p class="font-headline-md text-primary">Need more adventure?</p>
<p class="font-body-md text-on-surface-variant">Add a custom quest to your log.</p>
</div>
<button class="bg-primary text-on-primary font-label-bold px-8 py-3 rounded-full border-b-4 border-on-primary-container active:border-b-0 active:translate-y-1 transition-all uppercase tracking-widest">
                New Quest
            </button>
</div>
</main>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 w-full z-50 rounded-t-xl bg-surface dark:bg-inverse-surface border-t-4 border-surface-container-high dark:border-surface-dim flex justify-around items-end pb-4 px-2">
<a class="flex flex-col items-center justify-center text-primary dark:text-primary-fixed border-t-4 border-primary dark:border-primary-fixed pt-2 active:scale-95 transition-all hover:text-primary-container" href="#">
<span class="material-symbols-outlined text-3xl filled-icon">bolt</span>
<span class="font-label-bold text-label-bold">Today</span>
</a>
<a class="flex flex-col items-center justify-center text-outline dark:text-outline-variant pt-3 active:scale-95 transition-all hover:text-primary-container" href="#">
<span class="material-symbols-outlined text-3xl">calendar_today</span>
<span class="font-label-bold text-label-bold">Planner</span>
</a>
<a class="flex flex-col items-center justify-center text-outline dark:text-outline-variant pt-3 active:scale-95 transition-all hover:text-primary-container" href="#">
<span class="material-symbols-outlined text-3xl">leaderboard</span>
<span class="font-label-bold text-label-bold">Stats</span>
</a>
<a class="flex flex-col items-center justify-center text-outline dark:text-outline-variant pt-3 active:scale-95 transition-all hover:text-primary-container" href="#">
<span class="material-symbols-outlined text-3xl">group</span>
<span class="font-label-bold text-label-bold">Friends</span>
</a>
</nav>
<script>
        function toggleTask(element) {
            const checkbox = element.querySelector('.checkbox-container');
            const icon = checkbox.querySelector('.material-symbols-outlined');
            const headline = element.querySelector('h4');
            
            const isCompleted = element.classList.contains('completed');
            
            if (isCompleted) {
                // Untoggle
                element.classList.remove('completed');
                element.classList.remove('opacity-50');
                element.style.boxShadow = "0 4px 0 0 " + (element.classList.contains('border-primary') ? "#2b6c00" : "#becbb1");
                checkbox.classList.remove('bg-primary-container', 'border-primary');
                icon.classList.remove('text-on-primary-container', 'opacity-100');
                icon.classList.add('opacity-0');
                headline.classList.remove('line-through', 'opacity-50');
            } else {
                // Toggle complete
                element.classList.add('completed');
                element.classList.add('opacity-50');
                element.style.boxShadow = "none";
                element.style.transform = "translateY(4px)";
                checkbox.classList.add('bg-primary-container', 'border-primary');
                icon.classList.add('text-on-primary-container', 'opacity-100');
                icon.classList.remove('opacity-0');
                headline.classList.add('line-through', 'opacity-50');
                
                // Achievement effect simulation
                confettiEffect(element);
            }
        }

        function confettiEffect(element) {
            const rect = element.getBoundingClientRect();
            // In a real app, this would trigger a canvas animation or particle effect.
            // Here we just use a small scale bounce for tactile feedback.
            element.classList.add('scale-105');
            setTimeout(() => element.classList.remove('scale-105'), 200);
        }
    </script>
</body></html>




 <!-- Achievement Unlocked -->
<!DOCTYPE html>

<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Achievement Unlocked - 14 Day Streak</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@700;800&amp;family=Be+Vietnam+Pro:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        
        .chunky-shadow-primary {
            box-shadow: 0 6px 0 0 #1f5100;
        }
        .chunky-shadow-primary:active {
            box-shadow: 0 0px 0 0 #1f5100;
            transform: translateY(6px);
        }

        .chunky-shadow-secondary {
            box-shadow: 0 6px 0 0 #6a3b00;
        }
        .chunky-shadow-secondary:active {
            box-shadow: 0 0px 0 0 #6a3b00;
            transform: translateY(6px);
        }

        .chunky-shadow-card {
            box-shadow: 0 8px 0 0 rgba(0, 0, 0, 0.1);
        }

        .badge-float {
            animation: floating 3s ease-in-out infinite;
        }

        @keyframes floating {
            0% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(3deg); }
            100% { transform: translateY(0px) rotate(0deg); }
        }

        .confetti {
            position: absolute;
            width: 10px;
            height: 10px;
            border-radius: 2px;
            animation: fall 3s linear forwards;
            z-index: 10;
        }

        @keyframes fall {
            to {
                transform: translateY(100vh) rotate(720deg);
                opacity: 0;
            }
        }
    </style>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "on-primary": "#ffffff",
                        "surface-container-lowest": "#ffffff",
                        "secondary-container": "#fd9500",
                        "inverse-surface": "#303031",
                        "celebratory-purple": "#CE82FF",
                        "primary-container": "#58cc02",
                        "on-surface-variant": "#3f4a36",
                        "surface-container": "#efeded",
                        "on-background": "#1b1c1c",
                        "surface-card": "#FFFFFF",
                        "primary": "#2b6c00",
                        "secondary": "#8c5000",
                        "background": "#fbf9f9",
                        "on-primary-container": "#1e5000",
                        "surface": "#fbf9f9"
                    },
                    "spacing": {
                        "stack-md": "16px",
                        "margin-mobile": "16px",
                        "stack-lg": "24px",
                        "base-unit": "4px"
                    },
                    "fontFamily": {
                        "headline-lg-mobile": ["Plus Jakarta Sans"],
                        "display-hero": ["Plus Jakarta Sans"],
                        "body-md": ["Be Vietnam Pro"],
                        "label-bold": ["Be Vietnam Pro"]
                    },
                    "fontSize": {
                        "headline-lg-mobile": ["24px", {"lineHeight": "30px", "fontWeight": "800"}],
                        "display-hero": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "800"}],
                        "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "500"}],
                        "label-bold": ["14px", {"lineHeight": "20px", "letterSpacing": "0.05em", "fontWeight": "700"}]
                    }
                }
            }
        }
    </script>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-background text-on-surface font-body-md overflow-hidden min-h-screen flex flex-col">
<!-- Confetti Container -->
<div class="fixed inset-0 pointer-events-none" id="confetti-cannon"></div>
<!-- Main Content Canvas -->
<main class="flex-grow flex flex-col items-center justify-center px-margin-mobile relative z-20">
<!-- Badge Section -->
<div class="relative mb-stack-lg">
<!-- Glow Background Effect -->
<div class="absolute inset-0 bg-celebratory-purple opacity-20 blur-3xl rounded-full animate-pulse"></div>
<!-- 3D Badge Representation -->
<div class="badge-float relative">
<div class="w-48 h-48 md:w-64 md:h-64 bg-celebratory-purple border-4 border-on-background rounded-full flex items-center justify-center chunky-shadow-card">
<span class="material-symbols-outlined text-[96px] md:text-[128px] text-white" style="font-variation-settings: 'FILL' 1;">
                        workspace_premium
                    </span>
<!-- Star Detail -->
<div class="absolute top-4 right-4 bg-secondary-container p-3 rounded-full border-2 border-on-background">
<span class="material-symbols-outlined text-white" style="font-variation-settings: 'FILL' 1;">star</span>
</div>
</div>
</div>
</div>
<!-- Text Content -->
<div class="text-center max-w-md">
<h1 class="font-display-hero text-display-hero text-primary mb-stack-sm leading-tight">
                14-Day Streak Unlocked!
            </h1>
<p class="font-body-md text-body-md text-on-surface-variant mb-stack-lg">
                You're officially a <span class="text-secondary font-bold">Level 12 Warrior</span>. Keep it up!
            </p>
</div>
<!-- Stat Snapshot Card -->
<div class="w-full max-w-sm bg-white border-2 border-on-background rounded-xl p-stack-md mb-stack-lg chunky-shadow-card flex items-center justify-between">
<div class="flex items-center gap-3">
<div class="bg-primary-container p-2 rounded-lg">
<span class="material-symbols-outlined text-on-primary-container" style="font-variation-settings: 'FILL' 1;">local_fire_department</span>
</div>
<div>
<p class="font-label-bold text-label-bold text-on-surface-variant uppercase">Current Streak</p>
<p class="font-headline-lg-mobile text-headline-lg-mobile text-on-surface">14 Days</p>
</div>
</div>
<div class="text-right">
<p class="font-label-bold text-label-bold text-on-surface-variant uppercase">Next Tier</p>
<p class="font-headline-lg-mobile text-headline-lg-mobile text-secondary">21 Days</p>
</div>
</div>
<!-- Action Buttons -->
<div class="w-full max-w-sm space-y-stack-md pb-12">
<button class="w-full bg-primary-container text-on-primary-container py-5 px-stack-lg rounded-xl border-2 border-on-background font-headline-lg-mobile text-headline-lg-mobile chunky-shadow-primary transition-all flex items-center justify-center gap-3">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">share</span>
                Share with Friends
            </button>
<button class="w-full bg-surface-container-lowest text-on-surface-variant py-4 px-stack-lg rounded-xl border-2 border-on-background font-label-bold text-label-bold uppercase tracking-widest chunky-shadow-card active:translate-y-1 active:shadow-none transition-all flex items-center justify-center gap-2">
<span class="material-symbols-outlined">leaderboard</span>
                View Hall of Fame
            </button>
</div>
</main>
<!-- Close Button (Temporary Departure Check) -->
<button class="fixed top-margin-mobile right-margin-mobile w-12 h-12 rounded-full bg-white border-2 border-on-background flex items-center justify-center active:scale-90 transition-transform">
<span class="material-symbols-outlined">close</span>
</button>
<script>
        function createConfetti() {
            const container = document.getElementById('confetti-cannon');
            const colors = ['#58cc02', '#fd9500', '#CE82FF', '#4abdff', '#FF4B4B'];
            
            for (let i = 0; i < 50; i++) {
                const confetti = document.createElement('div');
                confetti.classList.add('confetti');
                
                // Random properties
                const color = colors[Math.floor(Math.random() * colors.length)];
                const left = Math.random() * 100 + 'vw';
                const size = Math.random() * 8 + 6 + 'px';
                const duration = Math.random() * 2 + 2 + 's';
                const delay = Math.random() * 3 + 's';

                confetti.style.backgroundColor = color;
                confetti.style.left = left;
                confetti.style.width = size;
                confetti.style.height = size;
                confetti.style.top = '-20px';
                confetti.style.animationDuration = duration;
                confetti.style.animationDelay = delay;
                
                container.appendChild(confetti);

                // Cleanup
                setTimeout(() => {
                    confetti.remove();
                }, 5000);
            }
        }

        // Trigger on load
        window.addEventListener('DOMContentLoaded', () => {
            createConfetti();
            // Repeat confetti occasionally
            setInterval(createConfetti, 4000);
        });

        // Micro-interaction for buttons
        const buttons = document.querySelectorAll('button');
        buttons.forEach(btn => {
            btn.addEventListener('touchstart', () => {
                btn.style.transform = 'scale(0.98)';
            });
            btn.addEventListener('touchend', () => {
                btn.style.transform = 'scale(1)';
            });
        });
    </script>
</body></html>

<!-- Monthly Planner -->
<!DOCTYPE html>

<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Quest Log - Monthly Planner</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;700;800&amp;family=Be+Vietnam+Pro:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
                    "on-primary": "#ffffff",
                    "surface-container-lowest": "#ffffff",
                    "secondary-fixed-dim": "#ffb872",
                    "on-tertiary-fixed-variant": "#004c6e",
                    "tertiary-fixed": "#c8e6ff",
                    "secondary-container": "#fd9500",
                    "inverse-surface": "#303031",
                    "inverse-primary": "#6be026",
                    "celebratory-purple": "#CE82FF",
                    "surface-tint": "#2b6c00",
                    "tertiary": "#006590",
                    "on-primary-fixed-variant": "#1f5100",
                    "surface-container-highest": "#e3e2e2",
                    "on-tertiary-container": "#004a6b",
                    "on-error-container": "#93000a",
                    "surface-container-low": "#f5f3f3",
                    "on-surface-variant": "#3f4a36",
                    "surface-container": "#efeded",
                    "tertiary-fixed-dim": "#88ceff",
                    "primary-container": "#58cc02",
                    "on-secondary": "#ffffff",
                    "surface-bright": "#fbf9f9",
                    "on-background": "#1b1c1c",
                    "border-depth": "rgba(0, 0, 0, 0.2)",
                    "surface-variant": "#e3e2e2",
                    "surface-bg": "#F7F7F7",
                    "on-tertiary-fixed": "#001e2e",
                    "outline": "#6f7b64",
                    "primary-fixed-dim": "#6be026",
                    "error-container": "#ffdad6",
                    "error": "#ba1a1a",
                    "tertiary-container": "#4abdff",
                    "inverse-on-surface": "#f2f0f0",
                    "on-surface": "#1b1c1c",
                    "on-primary-fixed": "#082100",
                    "outline-variant": "#becbb1",
                    "surface-container-high": "#e9e8e7",
                    "primary-fixed": "#87fe45",
                    "surface-card": "#FFFFFF",
                    "on-error": "#ffffff",
                    "primary": "#2b6c00",
                    "secondary": "#8c5000",
                    "on-secondary-container": "#633700",
                    "on-primary-container": "#1e5000",
                    "surface-dim": "#dbdad9",
                    "surface": "#fbf9f9",
                    "on-secondary-fixed": "#2d1600",
                    "on-secondary-fixed-variant": "#6a3b00",
                    "error-red": "#FF4B4B",
                    "secondary-fixed": "#ffdcbf",
                    "background": "#fbf9f9",
                    "on-tertiary": "#ffffff"
            },
            "borderRadius": {
                    "DEFAULT": "0.25rem",
                    "lg": "0.5rem",
                    "xl": "0.75rem",
                    "full": "9999px"
            },
            "spacing": {
                    "stack-md": "16px",
                    "margin-desktop": "32px",
                    "margin-mobile": "16px",
                    "stack-sm": "8px",
                    "gutter": "12px",
                    "stack-lg": "24px",
                    "base-unit": "4px"
            },
            "fontFamily": {
                    "headline-lg": ["Plus Jakarta Sans"],
                    "headline-md": ["Plus Jakarta Sans"],
                    "display-hero": ["Plus Jakarta Sans"],
                    "body-lg": ["Be Vietnam Pro"],
                    "headline-lg-mobile": ["Plus Jakarta Sans"],
                    "body-md": ["Be Vietnam Pro"],
                    "label-sm": ["Be Vietnam Pro"],
                    "label-bold": ["Be Vietnam Pro"]
            },
            "fontSize": {
                    "headline-lg": ["28px", {"lineHeight": "34px", "fontWeight": "800"}],
                    "headline-md": ["20px", {"lineHeight": "26px", "fontWeight": "700"}],
                    "display-hero": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "800"}],
                    "body-lg": ["18px", {"lineHeight": "26px", "fontWeight": "500"}],
                    "headline-lg-mobile": ["24px", {"lineHeight": "30px", "fontWeight": "800"}],
                    "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "500"}],
                    "label-sm": ["13px", {"lineHeight": "18px", "fontWeight": "400"}],
                    "label-bold": ["14px", {"lineHeight": "20px", "letterSpacing": "0.05em", "fontWeight": "700"}]
            }
          },
        },
      }
    </script>
<style>
        .chunky-card {
            box-shadow: 0 4px 0 0 #e3e2e2;
            transition: all 0.1s ease;
        }
        .chunky-card:active {
            transform: translateY(2px);
            box-shadow: 0 2px 0 0 #e3e2e2;
        }
        .chunky-button-primary {
            background-color: #58cc02;
            box-shadow: 0 4px 0 0 #2b6c00;
            transition: all 0.1s ease;
        }
        .chunky-button-primary:active {
            transform: translateY(4px);
            box-shadow: 0 0 0 0 #2b6c00;
        }
        .calendar-cell {
            aspect-ratio: 1 / 1;
            box-shadow: 0 2px 0 0 #e3e2e2;
        }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .filled-icon {
            font-variation-settings: 'FILL' 1;
        }
        body {
            background-color: #f7f7f7;
        }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="font-body-md text-on-surface">
<!-- TopAppBar -->
<header class="bg-surface dark:bg-on-background w-full top-0 sticky z-50 border-b-4 border-surface-container-highest dark:border-inverse-surface flex justify-between items-center px-margin-mobile py-stack-md w-full">
<div class="flex items-center gap-stack-sm">
<div class="w-10 h-10 rounded-full border-2 border-primary overflow-hidden">
<img class="w-full h-full object-cover" data-alt="A vibrant, high-energy 3D avatar of a young professional with a focused expression, wearing a stylized green tracksuit. The background is a clean, bright studio setting with soft volumetric lighting that emphasizes the chunky, playful aesthetic of the app's brand." src="https://lh3.googleusercontent.com/aida-public/AB6AXuADwuzJt532cgBgvdrsaMU0fYaMMJUFA8oNhVLcY-D640UifkZos2h-ohwLkimdWt8us8ZeoznFiZFSyQmla2r3Re5QgcQ-3oxFlY7EEQUZ7KBfvpZo3ZSPtSkFihlPTeDuzTeXOlTxpOVbplmGCOhuAR7LvSyDW1BfdUTvC97i8O-G3LTon1Lagm0Cr6g9brc1LNzOfsYEVKJ_PeIGSCZ6IpCXXTCUxZ6U65boTKW1d2SMyItfw2CV367E3Mwme3UWeMUcuPfjkm5h"/>
</div>
<h1 class="font-headline-lg-mobile text-headline-lg-mobile font-black text-primary dark:text-primary-fixed tracking-tight">Quest Log</h1>
</div>
<div class="flex items-center gap-2 bg-surface-container-low px-3 py-1 rounded-full border-2 border-surface-container-highest">
<span class="material-symbols-outlined text-secondary filled-icon">local_fire_department</span>
<span class="font-label-bold text-label-bold text-on-surface">12</span>
</div>
</header>
<main class="max-w-md mx-auto px-margin-mobile pb-32 pt-stack-lg space-y-stack-lg">
<!-- September Calendar Section -->
<section class="space-y-stack-md">
<div class="flex justify-between items-end">
<h2 class="font-headline-lg-mobile text-headline-lg-mobile text-on-surface">September</h2>
<div class="flex items-center gap-2 text-primary font-label-bold">
<span class="material-symbols-outlined text-sm">auto_graph</span>
<span>94% Consistency</span>
</div>
</div>
<div class="bg-surface-card rounded-xl border-2 border-surface-container-highest chunky-card p-4">
<div class="grid grid-cols-7 gap-2 mb-2">
<div class="text-center font-label-bold text-outline-variant text-xs">M</div>
<div class="text-center font-label-bold text-outline-variant text-xs">T</div>
<div class="text-center font-label-bold text-outline-variant text-xs">W</div>
<div class="text-center font-label-bold text-outline-variant text-xs">T</div>
<div class="text-center font-label-bold text-outline-variant text-xs">F</div>
<div class="text-center font-label-bold text-outline-variant text-xs">S</div>
<div class="text-center font-label-bold text-outline-variant text-xs">S</div>
</div>
<div class="grid grid-cols-7 gap-2">
<!-- Previous Month Days (Grayed) -->
<div class="calendar-cell bg-surface-container-low rounded-lg flex items-center justify-center text-outline-variant text-xs border-2 border-surface-container-highest">28</div>
<div class="calendar-cell bg-surface-container-low rounded-lg flex items-center justify-center text-outline-variant text-xs border-2 border-surface-container-highest">29</div>
<div class="calendar-cell bg-surface-container-low rounded-lg flex items-center justify-center text-outline-variant text-xs border-2 border-surface-container-highest">30</div>
<div class="calendar-cell bg-surface-container-low rounded-lg flex items-center justify-center text-outline-variant text-xs border-2 border-surface-container-highest">31</div>
<!-- September Days (Heatmap Style) -->
<script>
                        const heatmap = [
                            'bg-primary-container', 'bg-primary-container', 'bg-primary', 'bg-primary-container', 
                            'bg-primary', 'bg-primary-container', 'bg-primary-container', 'bg-primary',
                            'bg-primary-container', 'bg-primary', 'bg-primary', 'bg-surface-container-low',
                            'bg-primary-container', 'bg-primary-container', 'bg-primary', 'bg-primary-container',
                            'bg-primary-container', 'bg-primary', 'bg-primary-container', 'bg-primary-container',
                            'bg-primary', 'bg-primary-container', 'bg-primary-container', 'bg-primary',
                            'bg-primary-container', 'bg-primary', 'bg-primary-container', 'bg-primary',
                            'bg-primary-container', 'bg-primary-container'
                        ];
                        
                        heatmap.forEach((color, i) => {
                            const isToday = (i + 1) === 12;
                            document.write(`
                                <div class="calendar-cell ${color} rounded-lg flex items-center justify-center text-on-primary-container font-label-bold text-xs border-2 ${isToday ? 'border-secondary-container' : 'border-transparent'} relative">
                                    ${i + 1}
                                    ${isToday ? '<span class="absolute -top-1 -right-1 w-2 h-2 bg-secondary rounded-full"></span>' : ''}
                                </div>
                            `);
                        });
                    </script>
</div>
</div>
</section>
<!-- Monthly Goals Section -->
<section class="space-y-stack-md">
<h2 class="font-headline-lg-mobile text-headline-lg-mobile text-on-surface">Monthly Goals</h2>
<div class="space-y-stack-sm">
<!-- Goal Card 1 -->
<div class="bg-surface-card rounded-xl border-2 border-surface-container-highest chunky-card p-4 flex gap-4">
<div class="w-12 h-12 bg-tertiary-container rounded-xl flex items-center justify-center border-2 border-tertiary">
<span class="material-symbols-outlined text-on-tertiary-container filled-icon">menu_book</span>
</div>
<div class="flex-1 space-y-2">
<div class="flex justify-between items-center">
<span class="font-headline-md text-headline-md text-on-surface">Read 2 Books</span>
<span class="font-label-bold text-label-bold text-primary">1/2</span>
</div>
<div class="h-4 w-full bg-surface-container-highest rounded-full overflow-hidden border-2 border-surface-container-highest">
<div class="h-full bg-tertiary-container w-1/2 rounded-full border-r-2 border-tertiary"></div>
</div>
</div>
</div>
<!-- Goal Card 2 -->
<div class="bg-surface-card rounded-xl border-2 border-surface-container-highest chunky-card p-4 flex gap-4">
<div class="w-12 h-12 bg-celebratory-purple bg-opacity-30 rounded-xl flex items-center justify-center border-2 border-celebratory-purple">
<span class="material-symbols-outlined text-celebratory-purple filled-icon">fitness_center</span>
</div>
<div class="flex-1 space-y-2">
<div class="flex justify-between items-center">
<span class="font-headline-md text-headline-md text-on-surface">15 Gym Sessions</span>
<span class="font-label-bold text-label-bold text-primary">12/15</span>
</div>
<div class="h-4 w-full bg-surface-container-highest rounded-full overflow-hidden border-2 border-surface-container-highest">
<div class="h-full bg-celebratory-purple w-[80%] rounded-full"></div>
</div>
</div>
</div>
</div>
</section>
<!-- July Recurrence Preview -->
<section class="space-y-stack-md pb-8">
<div class="flex justify-between items-center">
<h2 class="font-headline-lg-mobile text-headline-lg-mobile text-on-surface">Plan for July</h2>
<button class="text-primary font-label-bold flex items-center gap-1">
<span class="material-symbols-outlined text-base">edit</span>
                    Edit
                </button>
</div>
<div class="grid grid-cols-2 gap-stack-sm">
<div class="bg-surface-card rounded-xl border-2 border-surface-container-highest chunky-card p-4 space-y-2">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-secondary filled-icon">event_repeat</span>
<span class="font-label-bold text-xs text-on-surface">Weekly Run</span>
</div>
<p class="text-sm text-on-surface-variant">Every Tuesday &amp; Thursday morning.</p>
</div>
<div class="bg-surface-card rounded-xl border-2 border-surface-container-highest chunky-card p-4 space-y-2">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-primary filled-icon">savings</span>
<span class="font-label-bold text-xs text-on-surface">Save $500</span>
</div>
<p class="text-sm text-on-surface-variant">Automatic transfer on July 1st.</p>
</div>
</div>
<!-- New Goal Action -->
<button class="w-full chunky-button-primary py-4 rounded-2xl flex items-center justify-center gap-2 text-white font-headline-md">
<span class="material-symbols-outlined font-bold">add_circle</span>
                ADD NEW QUEST
            </button>
</section>
</main>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 left-0 w-full z-50 flex justify-around items-center px-2 pb-safe pt-2 bg-surface dark:bg-on-background border-t-4 border-surface-container-highest dark:border-inverse-surface">
<div class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-2 hover:text-primary transition-colors active:scale-95 duration-100">
<span class="material-symbols-outlined">today</span>
<span class="font-label-bold text-label-bold">Today</span>
</div>
<div class="flex flex-col items-center justify-center bg-primary-container dark:bg-primary text-on-primary-container dark:text-on-primary rounded-xl px-4 py-2 border-b-4 border-on-primary-fixed-variant active:scale-95 transition-transform duration-100">
<span class="material-symbols-outlined filled-icon">calendar_month</span>
<span class="font-label-bold text-label-bold">Planner</span>
</div>
<div class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-2 hover:text-primary transition-colors active:scale-95 duration-100">
<span class="material-symbols-outlined">leaderboard</span>
<span class="font-label-bold text-label-bold">Stats</span>
</div>
<div class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-2 hover:text-primary transition-colors active:scale-95 duration-100">
<span class="material-symbols-outlined">group</span>
<span class="font-label-bold text-label-bold">Friends</span>
</div>
<div class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-2 hover:text-primary transition-colors active:scale-95 duration-100">
<span class="material-symbols-outlined">workspace_premium</span>
<span class="font-label-bold text-label-bold">Badges</span>
</div>
</nav>
<script>
        // Simple micro-interaction for calendar cells
        document.querySelectorAll('.calendar-cell').forEach(cell => {
            cell.addEventListener('click', () => {
                cell.classList.toggle('scale-95');
                setTimeout(() => cell.classList.toggle('scale-95'), 100);
            });
        });
    </script>
</body></html>