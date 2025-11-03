
<div class="flex items-center w-full px-6 lg:w-[40%]">
    <div class="flex-1">
        <div class="text-center">
            <div class="flex justify-center mx-auto">
                <img src="https://iconape.com/wp-content/files/ww/350307/png/350307.png"  class='w-56'/>
            </div>

            <jsp:include page="/views/components/heading.jsp">
                <jsp:param name="title" value="Give us your information"/>
                <jsp:param name="sub" value="Please enter your personal details to set up your account and personalize your experience"/>
            </jsp:include>
        </div>

        
            <form action="/SignUp" method="POST">
                <fieldset class="fieldset">
                    <legend class="fieldset-legend">Full Name *
                    </legend>
                    <input type="text" class="input w-full" placeholder="Enter your Full Name" />
                </fieldset>

                <fieldset class="fieldset">
                    <legend class="fieldset-legend">Email *
                    </legend>
                    <input type="email" class="input w-full" placeholder="Your email here" />
                </fieldset>

                <fieldset class="fieldset">
                    <legend class="fieldset-legend">Password *</legend>
                    <input type="password" class="input w-full" placeholder="Type your password" />
                </fieldset>

                <fieldset class="fieldset">
                    <legend class="fieldset-legend">Confirm Password *</legend>
                    <input type="password" class="input w-full" placeholder="Type your password" />
                </fieldset>

                <div class="mt-6 text-center">
                    <a href="#" class="btn btn-secondary w-full">Sign Up</a>
                </div>

            </form>

            <p class="mt-6 text-sm text-center text-gray-400">Do you already have an account? <a href="../login" class="text-secondary focus:outline-none focus:underline hover:underline">Login</a>.</p>
        
    </div>
</div>