Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7936F27153B
	for <lists+linux-block@lfdr.de>; Sun, 20 Sep 2020 17:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgITPEg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 20 Sep 2020 11:04:36 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:50472 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgITPEf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Sep 2020 11:04:35 -0400
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id D18C92810CD; Sun, 20 Sep 2020 16:55:42 +0200 (CEST)
Date:   Sun, 20 Sep 2020 16:55:42 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-video@atrey.karlin.mff.cuni.cz,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] Documentation/admin-guide: README & svga:
 remove use of "rdev"
Message-ID: <mj+md-20200920.145511.9167.nikam@ucw.cz>
References: <20200918015640.8439-1-rdunlap@infradead.org>
 <20200918015640.8439-2-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200918015640.8439-2-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

> "rdev" is considered antiquated, ancient, archaic, obsolete, deprecated
> {choose any or all}.
> 
> Remove use of "rdev" and "vidmode" (a symlink to rdev) in
> admin-guide/README.rst and admin-guide/svga.rst.

Acked-by: Martin Mares <mj@ucw.cz>

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
Press any key to quit or any other key to continue
