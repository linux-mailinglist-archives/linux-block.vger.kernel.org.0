Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F7329F6FB
	for <lists+linux-block@lfdr.de>; Thu, 29 Oct 2020 22:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgJ2Vfz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Oct 2020 17:35:55 -0400
Received: from smtprelay0163.hostedemail.com ([216.40.44.163]:44874 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725768AbgJ2Vfz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 17:35:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 97E28837F24A;
        Thu, 29 Oct 2020 21:35:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3871:4321:4384:5007:7576:7875:8957:10004:10400:10848:11026:11232:11657:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:12986:13439:14181:14659:14721:21080:21433:21451:21627:21990:30009:30045:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: arm95_560f16827290
X-Filterd-Recvd-Size: 3499
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 29 Oct 2020 21:35:51 +0000 (UTC)
Message-ID: <f810a6db9f617208302953c7cf837a8f8dd0e39f.camel@perches.com>
Subject: Re: [PATCH net-next 03/11] rsxx: remove extraneous 'const' qualifier
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Thu, 29 Oct 2020 14:35:50 -0700
In-Reply-To: <CAKwvOdka+UFvwntx-Dcx3oX2nJEkcdo+krm8gu016vPVBF8MBQ@mail.gmail.com>
References: <20201026213040.3889546-1-arnd@kernel.org>
         <20201026213040.3889546-3-arnd@kernel.org>
         <CAKwvOdka+UFvwntx-Dcx3oX2nJEkcdo+krm8gu016vPVBF8MBQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2020-10-29 at 12:34 -0700, Nick Desaulniers wrote:
> On Mon, Oct 26, 2020 at 2:31 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The returned string from rsxx_card_state_to_str is 'const',
> > but the other qualifier doesn't change anything here except
> > causing a warning with 'clang -Wextra':
> > 
> > drivers/block/rsxx/core.c:393:21: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
> > static const char * const rsxx_card_state_to_str(unsigned int state)
> > 
> > Fixes: f37912039eb0 ("block: IBM RamSan 70/80 trivial changes.")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Perhaps this should also be converted to avoid any possible
dereference of strings with an invalid state.
---
 drivers/block/rsxx/core.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 8799e3bab067..f50b00b4887f 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -390,15 +390,27 @@ static irqreturn_t rsxx_isr(int irq, void *pdata)
 }
 
 /*----------------- Card Event Handler -------------------*/
-static const char * const rsxx_card_state_to_str(unsigned int state)
+static const char *rsxx_card_state_to_str(unsigned int state)
 {
 	static const char * const state_strings[] = {
-		"Unknown", "Shutdown", "Starting", "Formatting",
-		"Uninitialized", "Good", "Shutting Down",
-		"Fault", "Read Only Fault", "dStroying"
+		"Unknown",		/* no bit set - all zeros */
+		"Shutdown",		/* BIT(0) */
+		"Starting",		/* BIT(1) */
+		"Formatting",		/* BIT(2) */
+		"Uninitialized",	/* BIT(3) */
+		"Good",			/* BIT(4) */
+		"Shutting Down",	/* BIT(5) */
+		"Fault",		/* BIT(6) */
+		"Read Only Fault",	/* BIT(7) */
+		"Destroying"		/* BIT(8) */
 	};
 
-	return state_strings[ffs(state)];
+	int i = ffs(state);
+
+	if (i >= ARRAY_SIZE(state_strings))
+		return "Invalid state";
+
+	return state_strings[i];
 }
 
 static void card_state_change(struct rsxx_cardinfo *card,
 

