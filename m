Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0A36378
	for <lists+linux-block@lfdr.de>; Wed,  5 Jun 2019 20:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFESmV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 5 Jun 2019 14:42:21 -0400
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:37284 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726535AbfFESmT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jun 2019 14:42:19 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2019 14:42:19 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 8868018008DBC
        for <linux-block@vger.kernel.org>; Wed,  5 Jun 2019 18:32:20 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C5FBE18224D68;
        Wed,  5 Jun 2019 18:32:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:966:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3866:3872:4250:4321:4385:4605:5007:6117:6248:7875:10004:10400:10848:11026:11232:11473:11658:11914:12048:12296:12555:12740:12760:12895:12986:13069:13311:13357:13439:14659:14721:14777:21080:21433:21627:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: love44_4e33dee382858
X-Filterd-Recvd-Size: 2595
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Jun 2019 18:32:17 +0000 (UTC)
Message-ID: <44c945bf0573842fe9b2db89407e40c88fcc7eb4.camel@perches.com>
Subject: Re: [PATCH] block: Drop unlikely before IS_ERR(_OR_NULL)
From:   Joe Perches <joe@perches.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Pravin B Shelar <pshelar@ovn.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Wed, 05 Jun 2019 11:32:14 -0700
In-Reply-To: <8221bc17-b0bb-da6f-4343-3e73467252d5@metux.net>
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
         <20190605142428.84784-4-wangkefeng.wang@huawei.com>
         <8221bc17-b0bb-da6f-4343-3e73467252d5@metux.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-06-05 at 18:24 +0000, Enrico Weigelt, metux IT consult
wrote:
> On 05.06.19 14:24, Kefeng Wang wrote:
> 
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index b97b479e4f64..1f7127b03490 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -881,7 +881,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
> >   			blkg_free(new_blkg);
> >   		} else {
> >   			blkg = blkg_create(pos, q, new_blkg);
> > -			if (unlikely(IS_ERR(blkg))) {
> > +			if (IS_ERR(blkg)) {
> >   				ret = PTR_ERR(blkg);
> >   				goto fail_unlock;
> >   			}
> > 
> 
> I think this cocci script should do such things automatically:
> 
> virtual patch
> virtual context
> virtual org
> virtual report
> 
> @@
> expression E;
> @@
> - unlikely(IS_ERR(E))
> + IS_ERR(E)

Likely change all of these too:

$ git grep -P '\blikely.*IS_ERR'
drivers/net/vxlan.c:    if (likely(!IS_ERR(rt))) {
fs/ntfs/lcnalloc.c:     if (likely(page && !IS_ERR(page))) {
fs/ntfs/mft.c:  if (likely(!IS_ERR(page))) {
fs/ntfs/mft.c:  if (likely(!IS_ERR(m)))
fs/ntfs/mft.c:          if (likely(!IS_ERR(m))) {
fs/ntfs/mft.c:          if (likely(!IS_ERR(rl2)))
fs/ntfs/namei.c:                if (likely(!IS_ERR(dent_inode))) {
fs/ntfs/runlist.c:      if (likely(!IS_ERR(old_rl)))
net/openvswitch/datapath.c:             if (likely(!IS_ERR(reply))) {
net/socket.c:   if (likely(!IS_ERR(newfile))) {


