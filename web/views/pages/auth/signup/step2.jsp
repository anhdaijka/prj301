<div class="flex items-center w-full px-6 lg:w-[40%]">
    <div class="flex-1">
        <div class="text-center">
            <div class="flex justify-center mx-auto">
                <img src="https://iconape.com/wp-content/files/ww/350307/png/350307.png"  class='w-56'/>
            </div>

            <jsp:include page="/views/layouts/heading.jsp">
                <jsp:param name="title" value="What is your location?"/>
                <jsp:param name="sub" value="We use this to match your nearby offers"/>
            </jsp:include>
        </div>

        <div class="mt-8">
            <form action="/SignUp" method="POST">
                <fieldset class="fieldset">
                    <legend class="fieldset-legend">Location
                    </legend>
                    <input type="text" class="input w-full" placeholder="Enter your location" />
                                        <label class="label">
                        <input type="checkbox" checked="checked" class="checkbox" />
                        I am Interested In Teleworking
                    </label>
                </fieldset>


                <fieldset class="fieldset">
                    <legend class="fieldset-legend">Postal code
                    </legend>
                    <input type="text" class="input w-full" placeholder="Enter your Postal code" />

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