<div class="flex items-center w-full px-6 lg:w-[40%]">
    <div class="flex-1">
        <div class="text-center">
            <div class="flex justify-center mx-auto">
                <img src="https://iconape.com/wp-content/files/ww/350307/png/350307.png"  class='w-56'/>
            </div>

            <jsp:include page="/views/layouts/heading.jsp">
                <jsp:param name="title" value="How much is the mininum salary You want?"/>
                <jsp:param name="sub" value="We use this to match your nearby offers that approximately pay this amount or more"/>
            </jsp:include>
        </div>

        <div class="mt-8">
            <form action="/SignUp" method="POST">
                <fieldset class="fieldset">
                    <legend class="fieldset-legend">Minimum Salary Amount
                    </legend>
                    <input type="text" class="input w-full" placeholder="Enter Minimum Salary Amount" />
                    <div role="alert" class="alert">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-4">
                            <path stroke-linecap="round" stroke-linejoin="round" d="m11.25 11.25.041-.02a.75.75 0 0 1 1.063.852l-.708 2.836a.75.75 0 0 0 1.063.853l.041-.021M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9-3.75h.008v.008H12V8.25Z" />
                        </svg>

                        <span class='text-sm'>Amount is by Euro</span>
                    </div>
                </fieldset>


                <fieldset class="fieldset">
                    <legend class="fieldset-legend">Payment Period
                    </legend>
                    <input type="text" class="input w-full" placeholder="Enter Payment Period" />

                </fieldset>


                <div class="mt-6 text-center">
                    <a href="#" class="btn btn-secondary w-full">Continue</a>
                </div>
                <div class="mt-2 text-center">
                    <a href="#" class="btn btn-ghost w-full">Skip</a>
                </div>

            </form>

        </div>
    </div>
</div>