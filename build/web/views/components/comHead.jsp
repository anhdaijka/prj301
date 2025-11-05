<section class="h-[25rem] w-full mb-[2.5rem] bg-base-300 shadow-sm hover:shadow-md">
    <div class="relative">
        <div class="w-full h-[12.5rem]">
            <img
                alt="profile"
                loading="lazy"
                width="832"
                height="416"
                decoding="async"
                data-nimg="1"
                class="w-full h-full object-cover object-bottom"
                src="${param.background}"
                style="color: transparent"
                />
        </div>
        <div
            class="absolute size-32 left-[0.8rem] bottom-[-4rem]"
            style="opacity: 1; transform: none"
            >
            <span
                data-slot="avatar"
                class="relative flex size-8 shrink-0 overflow-hidden rounded-full w-full h-full ring-2 ring-primary/60 ring-offset-1"
                ><img
                    data-slot="avatar-image"
                    class="aspect-square size-full object-cover"
                    src="${param.avatar}"
                    /></span>
        </div>
    </div>
    <div class="text-end mt-[0.5rem]">
        <button
            data-slot="button"
            class="btn btn-primary btn-lg btn-outline -translate-x-6"
            >
            <a href="https://anhdaik.vercel.app/contact">Get in Touch</a>
        </button>
    </div>
    <div class="flex flex-col items-start p-4 mt-4 relative bg-base-300 rounded-box shadow-sm">
        <h1 class="text-2xl font-bold flex items-center">
            ${param.name}<span class="ml-2"
                  >

                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 21h16.5M4.5 3h15M5.25 3v18m13.5-18v18M9 6.75h1.5m-1.5 3h1.5m-1.5 3h1.5m3-6H15m-1.5 3H15m-1.5 3H15M9 21v-3.375c0-.621.504-1.125 1.125-1.125h3.75c.621 0 1.125.504 1.125 1.125V21" />
                </svg>

            </span>
        </h1>
        <span class="text-gray-500 text-sm">${param.email}</span>
        <p class="mt-2 text-gray-600">@${param.name}</p>
        <div class="flex items-center gap-4 text-foreground text-sm mt-2">
            <div class="flex items-center gap-1">
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="24"
                    height="24"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="lucide lucide-map-pin size-4"
                    aria-hidden="true"
                    >
                    <path
                        d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"
                        ></path>
                    <circle cx="12" cy="10" r="3"></circle></svg
                ><span class="text-foreground/70">${param.location}</span>
            </div>
            <div class="flex items-center gap-1">
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="24"
                    height="24"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="lucide lucide-calendar-days size-4"
                    aria-hidden="true"
                    >
                    <path d="M8 2v4"></path>
                    <path d="M16 2v4"></path>
                    <rect width="18" height="18" x="3" y="4" rx="2"></rect>
                    <path d="M3 10h18"></path>
                    <path d="M8 14h.01"></path>
                    <path d="M12 14h.01"></path>
                    <path d="M16 14h.01"></path>
                    <path d="M8 18h.01"></path>
                    <path d="M12 18h.01"></path>
                    <path d="M16 18h.01"></path></svg
                ><span class="text-foreground/70">01/10/2015</span>
            </div>
        </div>
        <div class="flex items-center gap-4 text-md text-foreground mt-2">
            <p class="flex items-center gap-1">
                <span class="font-semibold">39</span
                ><span class="text-foreground/70">Jobs</span>
            </p>
            <p class="flex items-center gap-1">
                <span class="font-semibold">99.5k</span
                ><span class="text-foreground/70">Reviews</span>
            </p>
            <p class="flex items-center gap-1">
                <span class="font-semibold">1</span
                ><span class="text-foreground/70">Salaries</span>
            </p>
        </div>
        <ul class="flex space-x-2 absolute translate-y-12 right-4">
            <button
                data-slot="button"
                class="btn btn-circle btn-outline btn-primary"
                >
                <a target="_blank" href="https://github.com/1020phug"
                   ><svg
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        class="lucide lucide-github size-4"
                        aria-hidden="true"
                        >
                        <path
                            d="M15 22v-4a4.8 4.8 0 0 0-1-3.5c3 0 6-2 6-5.5.08-1.25-.27-2.48-1-3.5.28-1.15.28-2.35 0-3.5 0 0-1 0-3 1.5-2.64-.5-5.36-.5-8 0C6 2 5 2 5 2c-.3 1.15-.3 2.35 0 3.5A5.403 5.403 0 0 0 4 9c0 3.5 3 5.5 6 5.5-.39.49-.68 1.05-.85 1.65-.17.6-.22 1.23-.15 1.85v4"
                            ></path>
                        <path d="M9 18c-4.51 2-5-2-7-2"></path></svg
                    ></a></button
            ><button
                data-slot="button"
                class="btn btn-circle btn-outline btn-primary"

                >
                <a target="_blank" href="https://www.linkedin.com/in/1020phug"
                   ><svg
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        class="lucide lucide-linkedin size-4" 
                        aria-hidden="true"
                        >
                        <path
                            d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"
                            ></path>
                        <rect width="4" height="12" x="2" y="9"></rect>
                        <circle cx="4" cy="4" r="2"></circle></svg
                    ></a></button
            ><button
                data-slot="button"
                class="btn btn-circle btn-outline btn-primary"

                >
                <a target="_blank" href="https://instagram.com/anhdaik"
                   ><svg
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        class="lucide lucide-instagram size-4"
                        aria-hidden="true"
                        >
                        <rect width="20" height="20" x="2" y="2" rx="5" ry="5"></rect>
                        <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
                        <line x1="17.5" x2="17.51" y1="6.5" y2="6.5"></line></svg
                    ></a>
            </button>
        </ul>
    </div>
</section>
